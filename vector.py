from math import sqrt

class Vector(object):
    def __init__(self, coordinates):
        try:
            if not coordinates:
                raise ValueError
            self.coordinates = tuple(coordinates)
            self.dimension = len(coordinates)

        except ValueError:
            raise ValueError('The coordinates must be nonempty')

        except TypeError:
            raise TypeError('The coordinates must be an iterable')


    def __str__(self):
        return 'Vector: {}'.format(self.coordinates)


    def __eq__(self, v):
        return self.coordinates == v.coordinates

    def plus(self, v):
        new_coordinates = [x+y for x,y in zip(self.coordinates, v.coordinates)]
        return new_coordinates

    def minus(self, v):
        new_coordinates = [x-y for x,y in zip(self.coordinates, v.coordinates)]
        return new_coordinates

    def times_scalar(self, c):
        new_coordinates = [c*x for x in self.coordinates]
        return new_coordinates

    def magnitude(self):
        # he = 0
        # for x in self.coordinates:
        #     # print('x = {}'.format(x))
        #     he += x**2
        # # print('he = %f' % he)
        # return math.sqrt(he)
        coordinates_squared = [x**2 for x in self.coordinates]
        return sqrt(sum(coordinates_squared))

    def normalization(self):
        # mag = self.magnitude()
        # new_coordinates = self.times_scalar(1/mag)
        # return new_coordinates
        try:
            magnitude = self.magnitude()
            return self.times_scalar(1. / magnitude)
        except ZeroDivisionError:
            raise Exception('Cannot normalize the zero vector')

my_vector = Vector([1, 2, 3])
print(my_vector)
my_vector2 = Vector([1, 2, 3])
my_vector3 = Vector([-1, 2, 3])
print(my_vector == my_vector2)
print(my_vector2 == my_vector3)

print(my_vector.magnitude())
print(my_vector.normalization())

my_vector4 = Vector([-0.221, 7.437])
my_vector5 = Vector([8.813, -1.331, -6.247])
print(my_vector4.magnitude())
print(my_vector5.magnitude())

my_vector6 = Vector([5.581, -2.136])
my_vector7 = Vector([1.996, 3.108, -4.554])
print(my_vector6.normalization())
print(my_vector7.normalization())