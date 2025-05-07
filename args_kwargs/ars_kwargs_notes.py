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

# Output
# The value of your_name is Casey
# The value of my_name is Sammy

# Let’s now pass additional arguments to the function to show that **kwargs will accept however many arguments you would like to include:

def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))

print_values(
            name_1="Alex",
            name_2="Gray",
            name_3="Harper",
            name_4="Phoenix",
            name_5="Remy",
            name_6="Val"
        )

Output
The value of name_2 is Gray
The value of name_6 is Val
The value of name_4 is Phoenix
The value of name_5 is Remy
The value of name_3 is Harper
The value of name_1 is Alex

Ordering Arguments
When ordering arguments within a function or function call, arguments need to occur in a particular order:

Formal positional arguments
*args
Keyword arguments
**kwargs

def example(arg_1, arg_2, *args, **kwargs):
...

And, when working with positional parameters along with named keyword parameters in addition to *args and **kwargs, your function would look like this:

def example2(arg_1, arg_2, *args, kw_1="shark", kw_2="blobfish", **kwargs):
...

It is important to keep the order of arguments in mind when creating functions so that you do not receive a syntax error in your Python code.

We can also use *args and **kwargs to pass arguments into functions.

def some_args(arg_1, arg_2, arg_3):
    print("arg_1:", arg_1)
    print("arg_2:", arg_2)
    print("arg_3:", arg_3)

args = ("Sammy", "Casey", "Alex")
some_args(*args)

In the function above, there are three parameters defined as arg_1, arg_, and arg_3. The function will print out each of these arguments. We then create a variable that is set to an iterable (in this case, a tuple), and can pass that variable into the function with the asterisk syntax.

Output
arg_1: Sammy
arg_2: Casey
arg_3: Alex

We can also modify the program above to an iterable list data type with a different variable name. Let’s also combine the *args syntax with a named parameter:

def some_args(arg_1, arg_2, arg_3):
    print("arg_1:", arg_1)
    print("arg_2:", arg_2)
    print("arg_3:", arg_3)

my_list = [2, 3]
some_args(1, *my_list)

Output
arg_1: 1
arg_2: 2
arg_3: 3

Similarly, the keyworded **kwargs arguments can be used to call a function. We will set up a variable equal to a dictionary with 3 key-value pairs (we’ll use kwargs here, but it can be called whatever you want), and pass it to a function with 3 arguments:

def some_kwargs(kwarg_1, kwarg_2, kwarg_3):
    print("kwarg_1:", kwarg_1)
    print("kwarg_2:", kwarg_2)
    print("kwarg_3:", kwarg_3)

kwargs = {"kwarg_1": "Val", "kwarg_2": "Harper", "kwarg_3": "Remy"}
some_kwargs(**kwargs)

Output
kwarg_1: Val
kwarg_2: Harper
kwarg_3: Remy

Article:
https://www.digitalocean.com/community/tutorials/how-to-use-args-and-kwargs-in-python-3


