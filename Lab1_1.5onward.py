
# coding: utf-8

# In[24]:


import pandas as pd
import matplotlib.pyplot as plt
neuse = pd.read_csv('neuse_metric.txt', delimiter='\t', header=None)
neuse = neuse.rename(columns={0:'time',1:'value'})
neuse.plot(x='time', y='value')
plt.show()

# In[29]:


def check_zero(df):
    for val in df.value:
        if val == 0:
            print('We got a zero!')
    print('Done checking for zeros')
    return
check_zero(neuse)


# In[79]:


brf = pd.read_csv('brf_temp-1.6.txt', delimiter='\t', header=None)
brf = brf.rename(columns={0:'time',1:'value'})
brf.plot(x='time', y='value')
plt.show()

# In[96]:


#### how do I know what is a spike or dropout 
# and what is an actual temp change?
brf.difference = brf.diff(periods=1).value # the .diff method gets rate of change
print('temp change  ', 'time of change')
for i, val in enumerate(brf.difference):
    if abs(val) > 15:
        print(val, brf.time[i],)

