import strings
import numerics
import misc
import lists
import query
import discretization
import globalVars as d
import math
import Num
import Sym
import Data



# Examples Added to the CLI
examples_added = {}

# Register an example
def add_example(key, str, fun):
    global examples_added
    '''
    Adds an example that is runnable from the command line and updates the help menu
    '''
    examples_added[key] = fun
    d.help +=  f"  -g  {key}    {str}"

# How to use? First define a function, then add to the examples.
# def eg_function_0:
#   return the.some.missing.nested.field
# eg("crash","show crashing behavior", eg_function_1)

# def assert(x):
#   if not x:
#     raise Exception("Failed Assertion")

# The
def eg_function_the():
    return strings.oo(d.the)

# rand
def eg_function_0():
    t=[]
    u=[]

    d.Seed=1
    for i in range(1,1000):
       t.append(numerics.rint(0, 100))

    d.Seed=1
    for i in range(1,1000):
       u.append(numerics.rint(0, 100))

    for k,v in enumerate(t):
       assert(v==u[k], "test")

# some
def eg_function_1():
  d.the["Max"] = 32
  num1 = Num.Num()
  for i in range(1,10000):
    num1.add(i)

  strings.oo(query.has(num1))

def eg_function_2():
  num1,num2 = Num.Num(), Num.Num()
  for i in range(1,10000):
      num1.add(numerics.rand())
  for i in range(1,10000): 
      num2.add(numerics.rand()**2)
  print(1,numerics.rnd(query.mid(num1), 1), numerics.rnd(query.div(num1), 1))
  print(2,numerics.rnd(query.mid(num2), 1), numerics.rnd(query.div(num2), 2))
  t = numerics.rnd(query.mid(num1), 1)
  return .5 == numerics.rnd(query.mid(num1), 1) and query.mid(num1) > query.mid(num2)


def eg_function_3():
  sym=lists.adds(Sym.Sym(), ["a","a","a","a","b","b","c"])
  print (query.mid(sym), numerics.rnd(query.div(sym), 2))
  return 1.38 == numerics.rnd(query.div(sym), 2)

def eg_function_4():
  global n
  n=0
  def fun(t):
      global n
      n += len(t)

  strings.csv(d.the["file"], fun)
  return 3192 == n

def eg_function_5():
  data=Data.Data(d.the["file"])
  col=data.cols.x[0]
  print(col.lo, col.hi, query.mid(col), query.div(col))
  strings.oo(query.stats(data))

def eg_function_6():
  data1=Data.Data(d.the["file"])
  data2=data1.clone(data1.rows)
  strings.oo(query.stats(data1))
  strings.oo(query.stats(data2))

def eg_function_7():
  assert numerics.cliffsDelta([8, 7, 6, 2, 5, 8, 7, 3], [8, 7, 6, 2, 5, 8, 7, 3]) == False, "1"
  assert numerics.cliffsDelta([8, 7, 6, 2, 5, 8, 7, 3], [9, 9, 7, 8, 10, 9, 6]) == True, "2"
  t1, t2 = [], []
  for i in range(1000):
      t1.append(numerics.rand())
      t2.append(numerics.rand() ** 0.5)

  assert(numerics.cliffsDelta(t1, t1) == False, "3")
  assert(numerics.cliffsDelta(t1, t2) == True, "4")

  diff, j = False, 1.0
  while not diff:
      t3 = lists.map(t1, lambda x: x * j)
      diff = numerics.cliffsDelta(t1, t3)
      print(">", numerics.rnd(j, 2), diff)
      j *= 1.025

  def fun(x):
      global j
      return x*j

  while not diff:
    t3=lists.map(t1,fun)

def eg_function_8(): 
  data = Data.Data(d.the["file"]) 
  num  = Num.Num() 
  for _,row in data.rows.items(): 
    num.add(data.dist(row, data.rows[0])) 
  strings.oo({"lo":num.lo, 
              "hi":num.hi, 
              "mid":numerics.rnd(query.mid(num), 2), 
              "div":numerics.rnd(query.div(num), 2)}) 

def eg_function_9():
  data = Data.Data(d.the.get("file"))
  left,right,A,B,mid,c, evals = data.half()
  print(len(left),len(right))
  l,r = data.clone(left), data.clone(right)
  print("l",strings.o(query.stats(l)))
  print("r",strings.o(query.stats(r)))

def eg_function_10():
  misc.showTree(Data.Data(d.the["file"]).tree())

def eg_function_11():
  data = Data.Data(d.the["file"])
  best,rest,evals = data.sway()
  print("\nall ", strings.o(query.stats(data)))
  print("    ",   strings.o(query.stats(data,query.div)))
  print("\nbest", strings.o(query.stats(best)))
  print("    ",   strings.o(query.stats(best,query.div)))
  print("\nrest", strings.o(query.stats(rest)))
  print("    ",   strings.o(query.stats(rest,query.div)))
  print("\nall ~= best?", strings.o(numerics.diffs(best.cols.y, data.cols.y)))
  print("best ~= rest?", strings.o(numerics.diffs(best.cols.y, rest.cols.y)))

def eg_function_12():
  print("")
  data = Data.Data(d.the["file"])
  best,rest, evals = data.sway()
  print("all","","","", strings.o({"best":len(best.rows), "rest":len(rest.rows)}))
  print("")
  for k,t in discretization.bins(data.cols.x,{"best":best.rows, "rest":rest.rows}).items():
    for _,range in t.items():
      #if range.txt != b4:
      #      print("")
      #b4 = range.txt
      print(range.txt,range.lo,range.hi,
           numerics.rnd(discretization.value(range.y.has, len(best.rows),len(rest.rows),"best")),
           strings.o(range.y.has))
    print("")

def eg_function_13():
    data=Data.Data(d.the["file"]) 
    best,rest, evals = data.sway() 
    rule,most= data.xpln(best,rest) 
    print("\n-----------\nexplain=", strings.o(rule.showRule())) 
    data1= Data.Data(rule.selects(data.rows), datai = data) 
    print("all               ", strings.o(query.stats(data)), strings.o(query.stats(data, query.div))) 
    print(f"sway with {evals} evals", strings.o(query.stats(best)), strings.o(query.stats(best, query.div))) 
    print(f"xpln on {evals} evals", strings.o(query.stats(data1)), strings.o(query.stats(data1, query.div))) 
    top,_ = data.betters(len(best.rows)) 
    top = Data.Data(top, data2 = data) 
    print(f"sort with {len(data.rows)} evals",strings.o(query.stats(top)), strings.o(query.stats(top,query.div))) 

def add_all_examples():
        # add_example("the", "show settings", eg_function_the)
        # add_example("rand", "demo random number generation", eg_function_0)
        # add_example("some", "demo of reservoir sampling", eg_function_1)
        add_example("nums", "demo of NUM", eg_function_2)
        # add_example("syms", "demo SYMS", eg_function_3)
        # add_example("csv", "reading csv files", eg_function_4)
        # add_example("data",  "showing data sets", eg_function_5)
        # add_example("clone", "replicate structure of a DATA", eg_function_6)
        # add_example("cliffs", "stats tests", eg_function_7)
        # add_example("dist", "distance test", eg_function_8)
        # add_example("half", "divide data in half", eg_function_9)
        # add_example("tree", "make and show tree of clusters", eg_function_10)
        # add_example("sway", "optimizing", eg_function_11)
        # add_example("bins",  "find deltas between best and rest", eg_function_12)
        # add_example("xpln", "explore explanation sets", eg_function_13)