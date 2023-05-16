#!/usr/bin/env python3

from tkinter import Tk, Menu
from tkinter import filedialog
from tkinter import ttk


def filemenu_New():
    path = filedialog.askdirectory(initialdir = "./",title = "Select file")
    print(path)


root = Tk()

menubar = Menu(root)

filemenu = Menu(menubar, tearoff=0)
filemenu.add_command(label="New", command=filemenu_New)
menubar.add_cascade(label="Project", menu=filemenu)

notebook = ttk.Notebook(root)
notebook.pack(pady=10, expand=True)

frame1 = ttk.Frame(notebook, width=400, height=280)
frame1.pack(fill='both', expand=True)
notebook.add(frame1, text='General Information')

root.config(menu=menubar)
root.mainloop()

