.. _man-complex-and-rational-numbers:

.. currentmodule:: Base

******************************
 복소수와 유리수
******************************

Julia는 복소수와 유리수에 대한 타입을 사전 정의된 타입의 형태로 지니고 있으며, 
이 타입들은 :ref:`표준 수학 연산
<man-mathematical-operations>`\ 을 지원한다. 
또한 원시 타입이든 복합 타입든간에 이들 타입에 대해서 어떤 조합으로 이루어져도
:ref:`man-conversion-and-promotion`\ 을 지원하고 있다.

.. _man-complex-numbers:

복소수
---------------

전역 상수 :const:`im` 은 -1의 양의 제곱근인 복소수 *i*\ 를 뜻한다.
하지만 ``i``\ 는 인덱스 변수 이름으로써 널리 쓰이기 때문에 이를 
전역 상수로 쓰는 것은 굉장히 위험할 수 있다.
Julia에서는 :ref:`상수를 변수와 병치
<man-numeric-literal-coefficients>`\ 하는 것을 허용하기 때문에,
기존에 수학에서 쓰던 표기법과 비슷하게 복소수에서 비슷한 문법을 쓸 수 있다:

.. doctest::

    julia> 1 + 2im
    1 + 2im

또한 표준 수치 연산을 복소수에 대해서도 모두 동일하게 적용할 수 있다:

.. doctest::

    julia> (1 + 2im)*(2 - 3im)
    8 + 1im

    julia> (1 + 2im)/(1 - 2im)
    -0.6 + 0.8im

    julia> (1 + 2im) + (1 - 2im)
    2 + 0im

    julia> (-3 + 2im) - (5 - 1im)
    -8 + 3im

    julia> (-1 + 2im)^2
    -3 - 4im

    julia> (-1 + 2im)^2.5
    2.7296244647840084 - 6.960664459571898im

    julia> (-1 + 2im)^(1 + 1im)
    -0.27910381075826657 + 0.08708053414102428im

    julia> 3(2 - 5im)
    6 - 15im

    julia> 3(2 - 5im)^2
    -63 - 60im

    julia> 3(2 - 5im)^-1.0
    0.20689655172413796 + 0.5172413793103449im

프로모션 시스템은 서로 다른 타입의 피연산자끼리의 조합도 
간단하게 바로 적용가능하도록 만들어준다:

.. doctest::

    julia> 2(1 - 1im)
    2 - 2im

    julia> (2 + 3im) - 1
    1 + 3im

    julia> (1 + 2im) + 0.5
    1.5 + 2.0im

    julia> (2 + 3im) - 0.5im
    2.0 + 2.5im

    julia> 0.75(1 + 2im)
    0.75 + 1.5im

    julia> (2 + 3im) / 2
    1.0 + 1.5im

    julia> (1 - 3im) / (2 + 2im)
    -0.5 - 1.0im

    julia> 2im^2
    -2 + 0im

    julia> 1 + 3/4im
    1.0 - 0.75im

리터럴 계수는 나눗셈보다 우선순위가 높기 때문에 
``3/4im == 3/(4*im) == -(3/4*im)``\ 가 된다는 것을 
알아둘 필요가 있다.

복소수를 다루는 표준 함수들은 다음과 같다:

.. doctest::

    julia> real(1 + 2im)
    1

    julia> imag(1 + 2im)
    2

    julia> conj(1 + 2im)
    1 - 2im

    julia> abs(1 + 2im)
    2.23606797749979

    julia> abs2(1 + 2im)
    5

    julia> angle(1 + 2im)
    1.1071487177940904

일반적으로, 복소수의 절대값(:func:`abs`)은 그 복소수와 0과의 거리를 나타낸다.
:func:`abs2`\ 는 절대값의 제곱을 구할 때 쓰는 함수이며, 
복소수에서의 이 함수의 특별한 사용 용도는 제곱근을 구하기 어려울 때 쓴다.
:func:`angle`\ 은 위상각을 함수의 *매개변수*\ 로 많이 쓰이는
라디안으로 리턴하는 함수이다.
다른 모든 :ref:`man-elementary-functions`\ 들도 복소수에 대해 정의되어 있다.

.. doctest::

    julia> sqrt(1im)
    0.7071067811865476 + 0.7071067811865475im

    julia> sqrt(1 + 2im)
    1.272019649514069 + 0.7861513777574233im

    julia> cos(1 + 2im)
    2.0327230070196656 - 3.0518977991518im

    julia> exp(1 + 2im)
    -1.1312043837568135 + 2.4717266720048188im

    julia> sinh(1 + 2im)
    -0.4890562590412937 + 1.4031192506220405im

일반적으로 수학 관련 함수들은 실수에 적용되었을 때는 실수를, 
복소수에 적용되었을 때는 복소수를 리턴한다.
예를 들어, :func:`sqrt`\ 가 ``-1 == -1 + 0im``\ 임에도 불구하고,
``-1``\ 에 적용되었을 때와 ``-1 + 0im``\ 에 적용되었을 때 다르게 작동한다.

.. doctest::

    julia> sqrt(-1)
    ERROR: DomainError:
    sqrt will only return a complex result if called with a complex argument. Try sqrt(complex(x)).
     in sqrt(::Int64) at ./math.jl:185
     ...

    julia> sqrt(-1 + 0im)
    0.0 + 1.0im

:ref:`literal numeric coefficient notation <man-numeric-literal-coefficients>`\ 는
변수로부터 복소수를 만들 때는 작동하지 않는다. 대신에, 이 때는 곱셈 기호가 명시적으로
표시되어야 한다.

.. doctest::

    julia> a = 1; b = 2; a + b*im
    1 + 2im

하지만, 위 방법은 *추천하지 않는다*\; 대신에 :func:`complex`\ 를 써서 
실수부와 허수부를 직접 받아 복소수를 형성하는 것이 좋다:

.. doctest::

    julia> complex(a,b)
    1 + 2im

위의 복소수 형성방법은 곱셈과 덧셈 연산을 하지 않아도 된다.

:const:`Inf`\ 와 :const:`NaN`\ 를 복소수의 실수부 혹은 허수부에 적용하는 것은
:ref:`man-special-floats` 섹션에서 설명하고 있다:

.. doctest::

    julia> 1 + Inf*im
    1.0 + Inf*im

    julia> 1 + NaN*im
    1.0 + NaN*im

.. _man-rational-numbers:

유리수
----------------

Julia는 정수들 간의 비를 정확히 표현하기 위해 유리수 타입이 존재한다. 
유리수는 :obj:`//` 연산자를 이용하여 표현할 수 있다:

.. doctest::

    julia> 2//3
    2//3

만약 유리수타입에서 분모와 분자에 공통 인수가 있다면, 
분모에 음수가 들어가지 않는 방향으로 약분한 형태로 저장한다;

.. doctest::

    julia> 6//9
    2//3

    julia> -4//8
    -1//2

    julia> 5//-15
    -1//3

    julia> -4//-12
    1//3

위에서 언급한 약분된 형태의 유리수는 유일하기 때문에, 유리수 타입의 동등 비교는 
분모와 분자의 동등비교로 이루어 질 수 있다.
이 표준형 유리수의 분모와 분자는
:func:`num` 함수와 :func:`den` 함수를 이용하여 추출할 수 있다.

.. doctest::

    julia> num(2//3)
    2

    julia> den(2//3)
    3

일반적으로는 분모와 분자의 직접 비교는 필요하지 않은데, 
그 이유는 유리수에 대해 표준 산술 연산과 비교 연산이 정의되어 있기 때문이다.

.. doctest::

    julia> 2//3 == 6//9
    true

    julia> 2//3 == 9//27
    false

    julia> 3//7 < 1//2
    true

    julia> 3//4 > 2//3
    true

    julia> 2//4 + 1//6
    2//3

    julia> 5//12 - 1//4
    1//6

    julia> 5//8 * 3//12
    5//32

    julia> 6//5 / 10//7
    21//25

유리수는 쉽게 부동소수점 실수로 변환할 수 있다.

.. doctest::

    julia> float(3//4)
    0.75

유리수와 부동소수점 실수 간의 변환이 있어도 다음과 같이 
``a == 0`` 이면서 ``b == 0``\ 인 경우를 제외한 
임의의 정수 ``a``\ 와 ``b`` 에 대해서 
유리수와 부동소수점 실수 간의 동등 비교가 성립한다.

.. doctest::

    julia> isequal(float(a//b), a/b)
    true

무한대 유리수 또한 생성할 수 있다:

.. doctest::

    julia> 5//0
    1//0

    julia> -3//0
    -1//0

    julia> typeof(ans)
    Rational{Int64}

그러나, :const:`NaN` 유리수는 생성할 수 없다:

.. doctest::

    julia> 0//0
    ERROR: ArgumentError: invalid rational: zero(Int64)//zero(Int64)
     in Rational{Int64}(::Int64, ::Int64) at ./rational.jl:8
     in //(::Int64, ::Int64) at ./rational.jl:22
     ...

다른 타입과 마찬가지로, 프로모션 시스템은 
유리수와 다른 타입들 간의 상호작용을 어려움 없이 할 수 있도록 해준다:

.. doctest::

    julia> 3//5 + 1
    8//5

    julia> 3//5 - 0.5
    0.09999999999999998

    julia> 2//7 * (1 + 2im)
    2//7 + 4//7*im

    julia> 2//7 * (1.5 + 2im)
    0.42857142857142855 + 0.5714285714285714im

    julia> 3//2 / (1 + 2im)
    3//10 - 3//5*im

    julia> 1//2 + 2im
    1//2 + 2//1*im

    julia> 1 + 2//3im
    1//1 - 2//3*im

    julia> 0.5 == 1//2
    true

    julia> 0.33 == 1//3
    false

    julia> 0.33 < 1//3
    true

    julia> 1//3 - 0.33
    0.0033333333333332993

