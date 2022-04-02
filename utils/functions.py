import os
import webbrowser
from tkinter import messagebox
import getpass as gp

def linver_shell(script):
    # FUnção para conseguir algumas infomrações do sistema operacional que não
    # é possivel pegar com o Python
    
    os.system(f"{script}/utils/linver_shell.sh")
    try:
        information = open("/tmp/linver/linver.info", "r").readlines()
    except FileNotFoundError:
        print("No such file '/tmp/linver/linver.info'")
        return False
    info = {}
    for i in information:
        try:
            info[i.split(':')[0].strip()] = i.split(':')[1].strip()
        except IndexError:
            pass

    # os.system(f"rm -rf /tmp/linver")
    return info


def github(script):
    # Abrir o repositório do projeto no github pelo nevegador padrão
    user = gp.getuser()
    info = linver_shell(script)
    print(info["Login"], user)
    if info["Login"] == user:
        webbrowser.open("https://github.com/BrenoMartinsDeOliveiraVasconcelos/linver")
    else:
        messagebox.showinfo("Warning", "Cannot open default browser as root with normal user session.")
        