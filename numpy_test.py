# np.random.randn()
# np.random.rand(18)
# np.random.randint(low=2,high=100,size=100)
a = np.random.random(int(1e8))
import time
start = time.time()
sum(a) / len(a)
print(time.time() - start, 'seconds')

start = time.time()
np.mean(a)
print(time.time() - start, 'seconds')
