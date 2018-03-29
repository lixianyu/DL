from decimal import Decimal, getcontext
from math import sqrt, acos, pi

getcontext().prec = 13

class Vector(object):
    CANNOT_NORMALIZE_ZERO_VECTOR_MSG = 'Cannot normalize the zero vector'
    NO_UNIQUE_PARALLEL_COMPONENT_MSG = 'There is no parallel component'
    NO_UNIQUE_ORTHOGONAL_COMPONENT_MSG = 'There is no orthogonal component'
    ONLY_DEFINED_IN_TWO_THREE_DIMS_MSG = 'ONLY_DEFINED_IN_TWO_THREE_DIMS_MSG'

    def __init__(self, coordinates):
        try:
            if not coordinates:
                raise ValueError
            self.coordinates = tuple([Decimal(x) for x in coordinates])
            self.dimension = len(self.coordinates)

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
        # return new_coordinates
        return Vector(new_coordinates)

    def minus(self, v):
        new_coordinates = [x-y for x,y in zip(self.coordinates, v.coordinates)]
        # return new_coordinates
        return Vector(new_coordinates)

    def times_scalar(self, c):
        new_coordinates = [Decimal(c)*x for x in self.coordinates]
        # return new_coordinates
        return Vector(new_coordinates)

    def magnitude(self):
        # he = 0
        # for x in self.coordinates:
        #     # print('x = {}'.format(x))
        #     he += x**2
        # # print('he = %f' % he)
        # return math.sqrt(he)
        coordinates_squared = [x**2 for x in self.coordinates]
        return sqrt(sum(coordinates_squared))

    # Process of finding a unit vector in the same direction as a given vector.
    def normalization(self):
        # mag = self.magnitude()
        # new_coordinates = self.times_scalar(1/mag)
        # return new_coordinates
        try:
            magnitude = self.magnitude()
            return self.times_scalar(1./magnitude)
        except ZeroDivisionError:
            raise Exception(CANNOT_NORMALIZE_ZERO_VECTOR_MSG)

    def component_parallel_to(self, basis):
        try:
            u = basis.normalization()
            weight = self.dot(u)
            return u.times_scalar(weight)
        except Exception as e:
            if str(e) == self.CANNOT_NORMALIZE_ZERO_VECTOR_MSG:
                raise Exception(self.NO_UNIQUE_PARALLEL_COMPONENT_MSG)
            else:
                raise e

    def component_orthogonal_to(self, basis):
        try:
            projection = self.component_parallel_to(basis)
            return self.minus(projection)
        except Exception as e:
            if str(e) == self.NO_UNIQUE_PARALLEL_COMPONENT_MSG:
                raise Exception(self.NO_UNIQUE_ORTHOGONAL_COMPONENT_MSG)
            else:
                raise e

    def is_zero(self, tolerance=1e-10):
        return self.magnitude() < tolerance

    def is_parallel_to(self, v):
        return (self.is_zero() or v.is_zero() or (self.angle_with(v)) == 0 or (self.angle_with(v)) == pi)

    def is_orthogonal_to(self, v, tolerance=1e-10):
        return abs(self.dot(v)) < tolerance

    def dot(self, v):
        return Decimal(sum([x*y for x,y in zip(self.coordinates, v.coordinates)]))

    def area_of_parallelogram_with(self, v):
        cross_product = self.cross(v)
        return cross_product.magnitude()

    def area_of_triangle_with(self, v):
        # return self.area_of_parallelogram_with(v) / Decimal('2.0')
        return self.area_of_parallelogram_with(v) / 2.0

    def cross(self, w):
        try:
            x1, y1, z1 = self.coordinates
            x2, y2, z2 = w.coordinates
            new_coordinates = [y1*z2 - y2*z1, -(x1*z2 - x2*z1), x1*y2 - x2*y1]
            return Vector(new_coordinates)

        except ValueError as e:
            msg = str(e)
            if (msg == 'need more than 2 values to unpack' or
                    msg == 'not enough values to unpack (expected 3, got 2)'):
                if len(self.coordinates) == 2:
                    self_embedded_in_R3 = Vector(self.coordinates + ('0',))
                else:
                    self_embedded_in_R3 = self
                if len(w.coordinates) == 2:
                    w_embedded_in_R3 = Vector(w.coordinates + ('0',))
                else:
                    w_embedded_in_R3 = w
                return self_embedded_in_R3.cross(w_embedded_in_R3)
            elif (msg == 'too many values to unpack' or
                  msg == 'need more than 1 value to unpack'):
                raise Exception(self.ONLY_DEFINED_IN_TWO_THREE_DIMS_MSG)
            else:
                raise e
                # print('he'*29)
                # print(str(e))

    def angle_with(self, v, degree=False):
        try:
            u1 = self.normalization()
            u2 = v.normalization()
            dianji = u1.dot(u2)
            print('dianji = {}'.format(dianji))
            radians = acos(dianji)
            print('radias = {}'.format(radians))
            if degree:
                degrees_per_radian = 180. / pi
                return radians * degrees_per_radian
            else:
                return radians

        except Exception as e:
            if str(e) == self.CANNOT_NORMALIZE_ZERO_VECTOR_MSG:
                raise Exception('Cannot compute an angle with the zero vector')
            else:
                print('e = {}'.format(e))
                raise e

# v = Vector([8.462, 7.893])
# w = Vector([6.984, -5.975, 4.778])
# cro = v.cross(w)
# print(cro)
# print(v.is_orthogonal_to(cro))
# print(w.is_orthogonal_to(cro))
# print('#'*150)
#
# v = Vector([-8.987, -9.838, 5.031])
# w = Vector([-4.268, -1.861, -8.866])
# cro = v.cross(w)
# print('Area is : {}'.format(cro.magnitude()))
# print(v.area_of_parallelogram_with(w))
# print('*'*150)
#
# v = Vector([1.5, 9.547, 3.691])
# w = Vector([-6.007, 0.124, 5.772])
# cro = v.cross(w)
# print('Area is : {}'.format(cro.magnitude()/2))
# print(v.area_of_triangle_with(w))
# v = Vector([3.039, 1.879])
# b = Vector([0.825, 2.036])
# print(v.component_parallel_to(b))
# print('.............................')
#
# v = Vector([-9.88, -3.264, -8.159])
# b = Vector([-2.155, -9.353, -9.473])
# print(v.component_orthogonal_to(b))
# print('#######################################################')
#
# v = Vector([3.009, -6.172, 3.692, -2.51])
# b = Vector([6.404, -9.144, 2.759, 8.718])
# print(v.component_parallel_to(b))
# print(v.component_orthogonal_to(b))

vec1 = Vector([-7.579, -7.88])
# vec1 = Vector([-7.579, 16.88])
vec2 = Vector([22.737, 23.64])
print('vec1.angle_with(vec2) = {}'.format(vec1.angle_with(vec2)))
print(vec1.is_parallel_to(vec2))
# # print(vec1.is_orthogonal_to(vec2))
# print('vec1 * vec2 = {}'.format(vec1.dot(vec2)))
# print('vec1.normalization() = {}'.format(vec1.normalization()))
# print('vec2.normalization() = {}'.format(vec2.normalization()))
#
# vec3 = Vector([-2.029, 9.97, 4.172])
# vec4 = Vector([-9.231, -6.639, -7.245])
# print('vec3 * vec4 = {}'.format(vec3.dot(vec4)))
# print('vec3.normalization() = {}'.format(vec3.normalization()))
# print('vec4.normalization() = {}'.format(vec4.normalization()))
#
# vec5 = Vector([-2.328, -7.284, -1.214])
# vec6 = Vector([-1.821, 1.072, -2.94])
# print('vec5 * vec6 = {}'.format(vec5.dot(vec6)))
# print('vec5.normalization() = {}'.format(vec5.normalization()))
# print('vec6.normalization() = {}'.format(vec6.normalization()))


# vec1 = Vector([7.887, 4.138])
# vec2 = Vector([-8.802, 6.776])
# print(vec1.dot(vec2))
#
# vec3 = Vector([-5.955, -4.904, -1.874])
# vec4 = Vector([-4.496, -8.755, 7.103])
# print(vec3.dot(vec4))
#
# vec5 = Vector([3.183, -7.627])
# vec6 = Vector([-2.668, 5.319])
# print(vec5.angle_with(vec6))
#
# vec7 = Vector([7.35, 0.221, 5.188])
# vec8 = Vector([2.751, 8.259, 3.985])
# print(vec7.angle_with(vec8, True))
# my_vector = Vector([1, 2, 3])
# print(my_vector)
# my_vector2 = Vector([1, 2, 3])
# my_vector3 = Vector([-1, 2, 3])
# print(my_vector == my_vector2)
# print(my_vector2 == my_vector3)
#
# print(my_vector.magnitude())
# print(my_vector.normalization())
#
# my_vector4 = Vector([-0.221, 7.437])
# my_vector5 = Vector([8.813, -1.331, -6.247])
# print(my_vector4.magnitude())
# print(my_vector5.magnitude())
#
# my_vector6 = Vector([5.581, -2.136])
# my_vector7 = Vector([1.996, 3.108, -4.554])
# print(my_vector6.normalization())
# print(my_vector7.normalization())
print(__name__)
