



```python
import pandas as pd
import numpy as np

unames=['user_id','gender','age','occu','zip']
rnames=['user_id','movie_id','ratings','timestamp']
mnames=['movie_id','title','genre']

upath='영화평점,json/movielens/users.dat'
rpath='영화평점,json/movielens/ratings.dat'
mpath='영화평점,json/movielens/movies.dat'

users=pd.read_csv(upath,sep='::',header=None,names=unames)
ratings=pd.read_csv(rpath,sep='::',header=None,names=rnames)
movies=pd.read_csv(mpath,sep='::',header=None,names=mnames)






```

