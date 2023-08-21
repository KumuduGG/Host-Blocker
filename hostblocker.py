import tkinter as tk


def hostblocker(url):
    try:
        fh = open("C:/Windows/System32/drivers/etc/hosts", "a")

    except:
        output_text.insert("end","Run as an Administrator\n")
        return

    fh.write(f"\n0.0.0.0  {url}")
    fh.close()

    output_text.insert("end","Done.!\n")


def button_click():
    user_input = entry.get()
    hostblocker(user_input)

app = tk.Tk()
app.title("Host file blocker")

label = tk.Label(app, text="Enter url you need to block")
button = tk.Button(app, text="Enter", command=button_click)
entry = tk.Entry(app, width=50)
output_text = tk.Text(app, height=5, width=30)

label.pack()
entry.pack()
button.pack()
output_text.pack()

app.mainloop()




