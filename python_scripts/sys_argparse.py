import sys

def get_sum_of_num(num1,num2,num3):
  return(int(num1)+int(num2)+int(num3))

if __name__ == "__main__":
  num1 = sys.argv[1]
  num2 = sys.argv[2]
  num3 = sys.argv[3]
  print(get_sum_of_num(num1, num2, num3))
