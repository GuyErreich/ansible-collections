import os

import pytest


@pytest.fixture
def fake_result(mocker):
    def _make(msg="Hello\nWorld", changed=True, status="changed"):
        result = mocker.MagicMock()
        result._result = {"msg": msg}
        if changed:
            result._result["changed"] = True

        result.is_changed.return_value = status == "changed"
        result.is_skipped.return_value = status == "skipped"
        result.is_failed.return_value = status == "failed"
        result.is_unreachable.return_value = status == "unreachable"

        task = mocker.MagicMock()
        task._uuid = "task-123"
        task.get_name.return_value = "Mocked Task"
        task.check_mode = False
        task.no_log = False
        task.args = {}
        task.action = "debug"
        result._task = task
        result.task = task
        result._host = mocker.MagicMock()
        result._host.get_name.return_value = "localhost"
        result.host = result._host

        return result

    return _make


@pytest.fixture(autouse=True)
def configure_callback_options(mocker):
    """Initialize default callback plugin options used by ansible-core's parent class."""
    from plugins.callback.default_with_clean_msg import CallbackModule

    defaults = {
        "check_mode_markers": False,
        "show_task_path_on_failure": False,
        "show_per_host_start": False,
        "display_ok_hosts": True,
        "display_failed_stderr": False,
        "show_custom_stats": False,
        "result_format": "json",
        "pretty_results": None,
        "result_indentation": 4,
        "result_yaml_line_width": 136,
    }
    original_init = CallbackModule.__init__

    def _init(self, *args, **kwargs):
        original_init(self, *args, **kwargs)
        self._plugin_options = dict(defaults)

    mocker.patch.object(CallbackModule, "__init__", _init)


@pytest.fixture
def ansible_config_with_callback(tmp_path, monkeypatch):
    """
    Creates a temp ansible.cfg pointing to the custom callback plugin.
    Sets ANSIBLE_CONFIG to use it.
    """
    callback_dir = os.path.abspath("plugins/callback")
    config_path = tmp_path / "ansible.cfg"

    config_path.write_text(
        f"""
[defaults]
stdout_callback = default_with_clean_msg
callback_plugins = {callback_dir}
"""
    )

    monkeypatch.setenv("ANSIBLE_CONFIG", str(config_path))
    yield config_path
