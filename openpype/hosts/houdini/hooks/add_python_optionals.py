import os
import copy
from openpype.lib import PreLaunchHook


class AddPythonOptionals(PreLaunchHook):
    """Set current dir to workdir.

    Hook `GlobalHostDataHook` must be executed before this hook.
    """
    app_groups = ["houdini"]

    def execute(self):

        env = copy.deepcopy(self.launch_context.env)
        
        pythonpath = env.get("PYTHONPATH", [])
        openpype_root = os.getenv("OPENPYPE_REPOS_ROOT")
        python_optional_dir = os.path.join(
                openpype_root,
                "openpype",
                "vendor",
                "python",
                "optional",
                "houdini"
            )
        if pythonpath:
            pythonpath = [path for path in pythonpath.split(os.pathsep) if path]
        pythonpath.insert(0, python_optional_dir)
        pythonpath = list(set(pythonpath))
        env["PYTHONPATH"] = os.pathsep.join(pythonpath)
        self.launch_context.env = env
        self.log.debug("Added '{}' to launch context PYTHONPATH".format(python_optional_dir))
        self.log.debug("launch context full PYTHONPATH: \n\t- {}\n".format("\n\t- ".join(self.launch_context.env["PYTHONPATH"].split(os.pathsep))))