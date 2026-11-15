import  tkinter as tk
window = tk.Tk()
window.geometry("400x600")
window.title("Калькулятор")
window.config(bg = "#A73ABD")
label = tk.Label(window,text="Введите пример", font=("Arial", 12), bg = "green")
label.pack()

screen = tk.Entry(window, font=("Arial", 20))
screen.pack(padx= 10, pady= 20)

def get_text():
    text_input = int(screen.get())
    label.config(text=text_input)

def click():
    label.config(text="привет мир")

btn = tk.Button(window, text="клик", command=get_text, font=("Arial", 20))
btn.pack()














window.mainloop()
