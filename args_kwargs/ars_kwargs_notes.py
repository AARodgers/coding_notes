def multiply(x, y):
    print (x * y)

multiply(5, 4, 3)


# We can essentially create the same function and code that we showed in the first example, by removing x and y as function parameters, and instead replacing them with *args:
def multiply(*args):
    z = 1
    for num in args:
        z *= num
    print(z)

multiply(4, 5)
multiply(10, 9)
multiply(2, 3, 4)
multiply(3, 5, 10, 6)

The double asterisk form of **kwargs is used to pass a keyworded, variable-length argument dictionary to a function. Again, the two asterisks (**) are the important element here, as the word kwargs is conventionally used, though not enforced by the language.

Like *args, **kwargs can take however many arguments you would like to supply to it. However, **kwargs differs from *args in that you will need to assign keywords.

First, let’s print out the **kwargs arguments that we pass to a function. We’ll create a short function to do this:

def print_kwargs(**kwargs):
        print(kwargs)

Next, we’ll call the function with some keyworded arguments passed into the function:

def print_kwargs(**kwargs):
        print(kwargs)

print_kwargs(kwargs_1="Shark", kwargs_2=4.5, kwargs_3=True)

Let’s run the program above and look at the output:

python print_kwargs.py
Output
{'kwargs_3': True, 'kwargs_2': 4.5, 'kwargs_1': 'Shark'}

Let’s create another short program to show how we can make use of **kwargs. Here we’ll create a function
to greet a dictionary of names. First, we’ll start with a dictionary of two names:

def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))

print_values(my_name="Sammy", your_name="Casey")


