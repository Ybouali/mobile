# Piscine Mobile - Module 00

📱 *Introduction to Mobile App Development*

This repository contains solutions for the Piscine Mobile Module 00 subject. It progressively builds a calculator app from a simple button press to a fully working calculator, while practicing mobile UI and state management skills.

---

## 📂 Project Structure

```mobileModule00/
├── ex00/
├── ex01/
├── ex02/
└── calculator_app/```


---

## 🚀 Exercises

### ex00 - Basic Display
- Create a simple app with:
  - A centered `Text` widget
  - A `Button` below it
- When the button is tapped, print **"Button pressed"** in the debug console.
- Make sure the UI is responsive on multiple devices.

---

### ex01 - Say Hello to the World
- Start from ex00
- Toggle the displayed text between:
  - *Hello World!*
  - the original text
- on button press.

---

### ex02 - More Buttons (Calculator UI)
- Create a new project with:
  - An `AppBar` titled **"Calculator"**
  - Two `TextField`s initialized to `0`
  - A button grid with:
    - digits 0–9
    - `.`, `AC`, `C`, `=`
    - arithmetic operators: `+`, `-`, `*`, `/`
- When any button is pressed, log its label to the console.
- Ensure the UI is responsive on phones and tablets.

---

### calculator_app - It’s Alive!
- Start from `ex02` and extend it:
  - Implement a **working calculator**
  - Support:
    - `+`, `−`, `×`, `÷`
    - decimal numbers
    - negative numbers
    - delete last character
    - clear all
    - multi-operator expressions
  - Handle:
    - invalid inputs
    - division by zero
    - large numbers
  - Prevent crashes in edge cases.

---

## ✅ Submission & Evaluation

- Push each exercise to its respective folder:
  - `ex00`, `ex01`, `ex02`, `calculator_app`
- Follow the structure and naming strictly to pass peer evaluations.
- Perform thorough testing before submitting.
- Peer evaluations will open after the deadline and remain active for 24 hours. Missing evaluations will result in 0.

---

## 🛠️ Getting Started

1. Read the [subject PDF](https://cdn.intra.42.fr/pdf/pdf/143028/en.subject.pdf) carefully.
2. Use **Flutter** or another supported mobile framework.
3. Focus on clean, responsive design.
4. Commit your progress regularly.
5. Test edge cases thoroughly.

---

**Happy coding! 🚀**
