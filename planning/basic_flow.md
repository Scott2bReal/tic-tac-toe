How to translate my TTT app from RB120 to a web app? I have the logic, and the
classes defined with easy to use APIs. How do I use those classes in the context
of a web app? Should I use the `TTTGame` class from the original project?

1. Populate `lib` directory with files defining classes how I will use them in
   this app
2. Define a flow to the app. Use the logic from the `TTTGame#play` method to
   inform my decisions in designing this web app version

## Basic Game Flow

- Human picks a square
- If square is unoccupied, human marker goes on that square
- Check if human wins or board is full
- Computer moves
- Check if computer wins or board is full
- Display updated board if no one has won and board is not full
