nohup jupyter lab & # This command starts Jupyter Lab in the background.


nohup jupyter lab --NotebookApp.token='' --NotebookApp.password='' --no-browser --port=8888 > jupyterlab.log 2>&1 &
# # This will start Jupyter Lab in the background, without a token or password, and log output to jupyterlab.log
# To stop Jupyter Lab, you can use:
# ```bash
# kill $(pgrep -f jupyter-lab)
# ```
import os
import subprocess
def start_jupyter_lab():
    """
    Start Jupyter Lab in the background without a token or password.
    Logs output to jupyterlab.log.
    """
    command = [
        "nohup", "jupyter", "lab",
        "--NotebookApp.token=''",
        "--NotebookApp.password=''",
        "--no-browser",
        "--port=8888",
        "> jupyterlab.log",
        "2>&1", "&"
    ]

    # Join the command list into a single string
    command_str = ' '.join(command)

    # Execute the command
    subprocess.run(command_str, shell=True, check=True)
