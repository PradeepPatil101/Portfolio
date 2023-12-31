# Lists

import numerics
import copy as c
import math

def per(t, p=0.5):
    p_index = math.floor((p * len(t)) + 0.5)
    return get_nth_element(t,max(0, min(len(t)-1, p_index)))

def get_nth_element(d, n):
    keys = list(d.keys())
    if n < len(keys):
        return d[keys[n]]
    else:
        return None
    
def adds(col, t=None):
    if t is None:
        t = {}
    for x in t:
        col.add(x)
    return col

def push(t, x):
    # Push `x` to end of list; return `x` 
    if(type(t) == dict):
        t[len(t)] = x
    else:
        t.append(x)
    return x 

def map(t, fun): 
    # map a function `fun`(v) over list (skip nil results) 
    u = {}
    if(type(t) == dict):
        for k,v in t.items():
            v = fun(v)
            if k is None:
                k = 1+len(u)
            u[k] = v 
        return u
    else:
        for k,v in enumerate(t):
            v = fun(v)
            if k is None:
                k = 1+len(u)
            u[k] = v 
        return u

def kap(t, fun): 
    # map function `fun`(k,v) over list (skip nil results) 
    u={}
    for k,v in t.items():
        # print("------>" + str(v.txt))
        v, k = fun(k, v)
        if k is None:
            k = len(u) + 1
        u[k] = v
    return u

def sort2(t, fun): 
    # Return `t`,  sorted by `fun` (default= `<`)
    if type(t) == dict:
        r = t.items()
        return dict(sorted(r, key = fun))
    else: 
        return t.sort( key = fun)
    
def sort(d):
    items = list(d.items())
    items.sort(key=lambda x: x[1])
    return dict(items)
 

def keys(t): 
    # Return list of table keys, sorted
    return sort(kap(t, lambda k,_: k ))


def lt(x):
    # Return a function that sorts ascending on `x`
    def fun(a, b):
        return a[x] < b[x]
    return fun

def lt2(x):
    # Return a function that sorts ascending on `x`
    def fun(a):
        return getattr(a[1], x)
    return fun

def any(t):
    # Returns one items at random
    y = numerics.rint(len(t) - 1,0)
    return t[y]

def many(t, n):
    # Returns some items from `t`
    u = []
    for i in range(int(n)):
        u.append(any(t))
    return u

def last(t):
    if(type(t) == dict):
        return list(t.values())[-1]
    else:
        return t[-1]

# def copy(t, u=None):
#     if type(t) != "dict":
#         return t
#     u = {k: copy(v) for k, v in t.items()}
#     return u

def copy(t):
    u = c.deepcopy(t)
    return u

# Return a portion of `t`; go,stop,inc defaults to 1,#t,1.
# Negative indexes are supported.
# def slice(t, go, stop, inc = 1):
#   if go and go < 0:
#      go=len(t)+go
#   if stop and stop < 0:
#       stop=len(t)+stop
#   u=[]
#   for j in range((go or 1)//1,(stop or len(t))//1,(inc)//1):
#      u[1+len(u)]=t[j]
#   return u

def slice(t, go=None, stop=None, inc=None):
    if go is not None and go < 0:
        go = len(t) + go
    if stop is not None and stop < 0:
        stop = len(t) + stop
    u = []
    for j in range((go or 0), (stop or len(t)), (inc or 1)):
        u.append(t[j])
    return u

def RX(t,s=""):
  sort2(t, None)
  return {"name":s, "rank":0, "n":len(t), "show":"", "has":t}

gt = lambda x: lambda a: a[x]
