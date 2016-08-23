.. _man-integers-and-floating-point-numbers:

.. currentmodule:: Base

*************************************
 정수와 부동소수점으로 표현되는 실수
*************************************

정수와 부동소수점(floating-point)으로 표현되는 실수는
수치 연산에 있어서 가장 기본적인 구성 요소이다.
이와 같은 값들의 Julia 내부에서의 내장 표현은
숫자 프리미티브(numeric primitives)이라고 하고,
실수나 부동소수점처럼 코드상에서 즉각적으로 표현되는 값들은
수치형 리터럴(numeric literal)이라고 알려져 있다.
예를 들면, ``1``\ 은 정수형 리터럴이지만,
``1.0``\ 은 부동소수점 리터럴이다;
그리고 위 리터럴들이 바이너리 형태로 메모리상에서 표현되는 객체(object)를
숫자 프리미티브(numeric primitives)라고 한다.

Julia는 넓은 범위의 기본 수치 타입과
수치 연산자, 그리고 비트 연산자를 모두 제공한다.
또한 전 문장에서 언급한 타입과 연산자에 기초한
표준 수학 함수들도 내장하고 있다.
현대의 컴퓨터에서 기본으로 제공되는
Julia에 내장된 표준 수학 함수들은
Julia로 하여금 연산 자원을 최대한 활용하도록 할 수 있도록 한다.
게다가, Julia는 하드웨어에서 기본적으로 표현하지 못하는
숫자들을 표현할 수 있게 만든
:ref:`man-arbitrary-precision-arithmetic`\ 도 지원한다.
그러나, :ref:`man-arbitrary-precision-arithmetic`\ 을 사용하면
성능상으로 느려질 수 있다.

다음은 Julia에서 기본적으로 지원하는 타입이다:

-  **정수형 타입:**

================  ========  =========      ============== ==================
타입              부호여부  비트 수        최솟값         최댓값
================  ========  =========      ============== ==================
:class:`Int8`        ✓         8            -2^7             2^7 - 1
:class:`UInt8`                 8             0               2^8 - 1
:class:`Int16`       ✓         16           -2^15            2^15 - 1
:class:`UInt16`                16            0               2^16 - 1
:class:`Int32`       ✓         32           -2^31            2^31 - 1
:class:`UInt32`                32            0               2^32 - 1
:class:`Int64`       ✓         64           -2^63            2^63 - 1
:class:`UInt64`                64            0               2^64 - 1
:class:`Int128`      ✓         128           -2^127          2^127 - 1
:class:`UInt128`               128           0               2^128 - 1
:class:`Bool`       N/A        8           ``false`` (0)  ``true`` (1)
================  ========  =========      ============== ==================

-  **부동소수점 타입:**

================ ======= ==============
타입             정밀도  비트수
================ ======= ==============
:class:`Float16` half_          16
:class:`Float32` single_        32
:class:`Float64` double_        64
================ ======= ==============

.. _half: https://en.wikipedia.org/wiki/Half-precision_floating-point_format
.. _single: https://en.wikipedia.org/wiki/Single_precision_floating-point_format
.. _double: https://en.wikipedia.org/wiki/Double_precision_floating-point_format

추가적으로, :ref:`man-complex-and-rational-numbers` 는 위에서 언급한
타입에 기초하여 만들어졌다.
모든 기본 수치 타입들은 유연하고, 쉽게 확장이 가능한
:ref:`type promotion system <man-conversion-and-promotion>` 덕분에
명시적인 캐스팅(explicit casting) 없이 자유롭게 상호운용이 가능하다.

정수
----

정수 리터럴은 다음과 같은 표준적인 방식으로 표현한다:

.. doctest::

    julia> 1
    1

    julia> 1234
    1234

정수 리터럴은 해당 시스템이
32비트 아키텍처인지 혹은 64비트 아키텍처인지에 따라
타입이 결정된다.::


    # 32비트 시스템:
    julia> typeof(1)
    Int32

    # 64비트 시스템:
    julia> typeof(1)
    Int64

Julia의 내부 변수 :const:`Sys.WORD_SIZE`\ 는 해당 시스템이
32비트인지 64비트인지 알려주는 역할을 한다.::

    # 32비트 시스템:
    julia> Sys.WORD_SIZE
    32

    # 64비트 시스템:
    julia> Sys.WORD_SIZE
    64

Julia는 부호가 있는 정수형과 부호가 없는 정수형을 위해
:class:`Int`\ 와 :class:`UInt`\ 라는 타입 또한 정의하고 있다.::

    # 32비트 시스템:
    julia> Int
    Int32
    julia> UInt
    UInt32


    # 64비트 시스템:
    julia> Int
    Int64
    julia> UInt
    UInt64

32비트로 표현할 수 없지만 64비트로 표현이 가능한 큰 정수형 리터럴은
시스템의 타입과는 상관없이 항상 64비트를 생성한다.::


    # 32비트 혹은 64비트 시스템:
    julia> typeof(3000000000)
    Int64

부호가 없는 정수형의 입출력은 항상 ``0x``\ 라는 접두어가 붙으며
16진수는 ``0-9a-f``\ 범위의 숫자와 문자를 쓴다.
(입력할 때 대문자 ``A-F``\ 도 쓸 수 있다.)
부호가 없는 값의 크기는 헥사 문자열을 쓴 개수에 따라 결정한다.

.. doctest::

    julia> 0x1
    0x01

    julia> typeof(ans)
    UInt8

    julia> 0x123
    0x0123

    julia> typeof(ans)
    UInt16

    julia> 0x1234567
    0x01234567

    julia> typeof(ans)
    UInt32

    julia> 0x123456789abcdef
    0x0123456789abcdef

    julia> typeof(ans)
    UInt64

일반적으로 부호가 없는 16진수 정수 리터럴을 쓸 때,
단순히 정수를 표현하기 보다는
사람들은 고정된 바이트 시퀀스(fixed numeric byte sequence)를
표현하기 위해 16진수를 쓰는 경향이 있기 때문에,
위와 같이 부호가 없는 정수형에 16진수형태를 결합시키도록 하였다.

:data:`ans`\ 가 대화형 실행 환경에서 가장 최근에 실행된 표현식의 결과를
나타내었다는 것을 떠올려보면, 위의 Julia 코드는 다른 환경에서는
제대로 실행이 안될 것이라는 것을 알 수 있다.

Julia는 2진수와 8진수 리터럴 또한 지원한다:

.. doctest::

    julia> 0b10
    0x02

    julia> typeof(ans)
    UInt8

    julia> 0o10
    0x08

    julia> typeof(ans)
    UInt8

정수형과 같은 기본 수치 타입의 최소값과 최대값은
:func:`typemin`\ 과 :func:`typemax`\ 함수를 통해 알 수 있다.

.. doctest::

    julia> (typemin(Int32), typemax(Int32))
    (-2147483648,2147483647)

    julia> for T in [Int8,Int16,Int32,Int64,Int128,UInt8,UInt16,UInt32,UInt64,UInt128]
             println("$(lpad(T,7)): [$(typemin(T)),$(typemax(T))]")
           end
       Int8: [-128,127]
      Int16: [-32768,32767]
      Int32: [-2147483648,2147483647]
      Int64: [-9223372036854775808,9223372036854775807]
     Int128: [-170141183460469231731687303715884105728,170141183460469231731687303715884105727]
      UInt8: [0,255]
     UInt16: [0,65535]
     UInt32: [0,4294967295]
     UInt64: [0,18446744073709551615]
    UInt128: [0,340282366920938463463374607431768211455]

:func:`typemin`\ 과 :func:`typemax`\ 가 제공하는 값들은
항상 매개변수의 타입과 같은 타입을 가진다.
(위 예제에서 쓰는 :ref:`for loops <man-loops>`\ ,
:ref:`man-strings`\ , :ref:`man-string-interpolation`\ 
과 같은 표현들은 아직 소개하지 않은 것들이다.
그러나 약간의 프로그래밍 지식이 있다면 이해하기에 별 문제가 없을 것이다.)


오버플로우(Overflow) 동작
~~~~~~~~~~~~~~~~~~~~~~~~~

Julia에서는 주어진 타입에서 표현할 수 있는 값을 넘어서게 되면
다음과 같이 주어진 범위를 벗어나지 않는(wraparound) 동작을 보여준다.

.. doctest::

    julia> x = typemax(Int64)
    9223372036854775807

    julia> x + 1
    -9223372036854775808

    julia> x + 1 == typemin(Int64)
    true

위와 같기 때문에, Julia 정수의 연산은 사실
`나머지 연산 <https://en.wikipedia.org/wiki/Modular_arithmetic>`_\ 임을
알 수 있다.
오버플로우가 나올 수 있는 프로그램에서는,
오버플로우를 명시적으로 체크하는 것이 필수적이다;
그런 경우가 아니라면
:ref:`man-arbitrary-precision-arithmetic`\ 에서 ``BigInt``\ 타입을
사용하는 것을 추천한다.

나눗셈 관련 에러들
~~~~~~~~~~~~~~~~~~

정수의 나눗셈 연산 (``div`` 함수)는 두 가지 예외적인 경우가 있다;
0으로 나누기, 그리고 컴퓨터가 표현할 수 있는 최소의 음의 정수값을
-1로 나누는 것이다.
두 가지 경우 모두 :exc:`DivideError`\ 를 유발한다.
두 `나머지` 연산 함수(remainder 와 modulus, ``rem``\ 와 ``mod``\ )는
두번째 매개변수가 0일 때 :exc:`DivideError`\ 를 던진다(throw).

부동소수점으로 표현되는 실수
----------------------------

부동소수점 리터럴은 표준 포맷을 이용하여 표현된다.:

.. doctest::

    julia> 1.0
    1.0

    julia> 1.
    1.0

    julia> 0.5
    0.5

    julia> .5
    0.5

    julia> -1.23
    -1.23

    julia> 1e10
    1.0e10

    julia> 2.5e-4
    0.00025

위에 나온 결과는 모두 ``Float64`` 타입의 값들이다.
``Float32`` 값들은 ``e`` 대신에 ``f``\ 를 쓰면 입력할 수 있다.

.. doctest::

    julia> 0.5f0
    0.5f0

    julia> typeof(ans)
    Float32

    julia> 2.5f-4
    0.00025f0

값들은 쉽게 ``Float32`` 타입으로 변환할 수 있다.

.. doctest::

    julia> Float32(-1.5)
    -1.5f0

    julia> typeof(ans)
    Float32

16진수로 표현되는 부동소수점 리터럴은 유효하지만,
``Float64`` 타입에서만 가능하다.

.. doctest::

    julia> 0x1p0
    1.0

    julia> 0x1.8p3
    12.0

    julia> 0x.4p-1
    0.125

    julia> typeof(ans)
    Float64

16비트의 정밀도를 가지는 반정도 부동소수점도 지원된다. (``Float16``\ )
하지만 메모리에 저장할 때만 쓰이고 계산할 때는 자동으로
``Float32``\ 로 변환된다.

.. doctest::

    julia> sizeof(Float16(4.))
    2

    julia> 2*Float16(4.)
    Float16(8.0)

밑줄 ``_``\ 는 수 구분자로 쓰일 수 있다.

.. doctest::

    julia> 10_000, 0.000_000_005, 0xdead_beef, 0b1011_0010
    (10000,5.0e-9,0xdeadbeef,0xb2)

실수로서의 숫자 0
~~~~~~~~~~~~~~~~~~

부동소수점은 양수 0과 음수 0으로 불리우는
`두 개의 0 <https://en.wikipedia.org/wiki/Signed_zero>`_\ 을
가진다. 그 둘은 값은 0으로써 같지만,
다음과 같이 ``bits`` 함수를 이용하면 알 수 있듯이,
바이너리로 표기했을 때 다르다는 것을 알 수 있다.

.. doctest::

    julia> 0.0 == -0.0
    true

    julia> bits(0.0)
    "0000000000000000000000000000000000000000000000000000000000000000"

    julia> bits(-0.0)
    "1000000000000000000000000000000000000000000000000000000000000000"

.. _man-special-floats:

특별한 부동소수점 값들
~~~~~~~~~~~~~~~~~~~~~~~

다음은 실수에는 포함되지는 않은
세 종류의 특정 표준 부동소수점이 있다.

=========== =========== ===========  ================= =================================================================
특별한 값                            이름              설명
-----------------------------------  ----------------- -----------------------------------------------------------------
``Float16`` ``Float32`` ``Float64``
=========== =========== ===========  ================= =================================================================
``Inf16``   ``Inf32``    ``Inf``     positive infinity 모든 유한한 부동소수점 실수보다 큰 값
``-Inf16``  ``-Inf32``   ``-Inf``    negative infinity 모든 유한한 부동소수점 실수보다 작은 값
``NaN16``   ``NaN32``    ``NaN``     not a number      어떠한 부동소수점 실수와도 같지 않은 값 (자기 자신 포함)
=========== =========== ===========  ================= =================================================================

이와 같은 유한하지 않은 부동소수점 값들이
서로와 다른 실수에 대해서 순서를 매길 때에는,
:ref:`man-numeric-comparisons`\ 를 참고하길 바란다.
`IEEE 754 standard <https://en.wikipedia.org/wiki/IEEE_754-2008>`_\ 에 따르면,
위에서의 부동소수점 실수들은 어떤 산술 연산에 의한 결과임을 알 수 있다.

.. doctest::

    julia> 1/Inf
    0.0

    julia> 1/0
    Inf

    julia> -5/0
    -Inf

    julia> 0.000001/0
    Inf

    julia> 0/0
    NaN

    julia> 500 + Inf
    Inf

    julia> 500 - Inf
    -Inf

    julia> Inf + Inf
    Inf

    julia> Inf - Inf
    NaN

    julia> Inf * Inf
    Inf

    julia> Inf / Inf
    NaN

    julia> 0 * Inf
    NaN

:func:`typemin`\ 과 :func:`typemax` 함수는
부동소수점 타입에도 적용이 가능하다.

.. doctest::

    julia> (typemin(Float16),typemax(Float16))
    (-Inf16,Inf16)

    julia> (typemin(Float32),typemax(Float32))
    (-Inf32,Inf32)

    julia> (typemin(Float64),typemax(Float64))
    (-Inf,Inf)

계산기 입실론(Machine epsilon)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

대부분의 실수들은 부동소수점 형태로는 정확하게 표현할 수 없다.
그리고 현재로서는 많은 경우 두 인접한 부동소수점으로 표현 가능한 실수가
얼만큼 떨어져 있는 지 알 필요가 있다.
따라서 이를 위해 계산기 입실론(machine epsilon)이라는 개념이 도입하게 되었다.

Julia는 :func:`eps`\ 라는 것을 제공한다.
이는 표현 가능한 부동소수점 실수 중에서 ``1.0`` 과
``1.0``\ 보다 크면서 ``1.0``\ 의 옆에 있는 값과의 거리를 말한다.

.. doctest::

    julia> eps(Float32)
    1.1920929f-7

    julia> eps(Float64)
    2.220446049250313e-16

    julia> eps() # same as eps(Float64)
    2.220446049250313e-16

위 코드에서 나오는 ``eps`` 값들은
``Float32``\ 와 ``Float64`` 값 중에서 바이너리로 표기했을 때
``2.0^-23`` 과 ``2.0^-52``\ 를 각각 나타낸다.
:func:`eps` 함수는 부동소수점 실수를 매개변수로 받을 수도 있는데,
이 때는 ``1.0``\ 이 아니라 주어진 값과 주어진 값 바로 옆에서
주어진 값과의 거리를 반환한다.
그 말은 ``eps(x)``\ 의 반환값은 ``x``\ 와 같은 타입이고,
``x + eps(x)``\ 는 ``x``\ 보다 큰 ``x`` 바로 옆에 있는
표현 가능한 부동소수점 실수를 뜻한다.

.. doctest::

    julia> eps(1.0)
    2.220446049250313e-16

    julia> eps(1000.)
    1.1368683772161603e-13

    julia> eps(1e-27)
    1.793662034335766e-43

    julia> eps(0.0)
    5.0e-324

두 인접하면서 표현 가능한 부동소수점 실수들은 상수가 아니지만,
작은 값에서는 작은 값을 지니고, 큰 값들에서는 큰 값을 나타낸다.
다른 말로 말하면, 표현 가능한 부동소수점 실수들은 실수축 상에서
0에 근접할 때 가장 밀집되어있고, 0에서 멀어질수록 점점 드물다.
정의에 의하면, ``eps(1.0)``\ 은 ``eps(Float64)``\ 와 같은데, 그 이유는
``1.0``\ 은 64비트 부동소수점 실수이기 때문이다.

또한 Julia는 :func:`nextfloat`\ 과 :func:`prevfloat` 함수를 제공하는데 이는,
표현 가능한 부동소수점 실수 중에서 주어진 실수 바로 옆에 있는
크거나 작은 수를 반환한다.

.. doctest::

    julia> x = 1.25f0
    1.25f0

    julia> nextfloat(x)
    1.2500001f0

    julia> prevfloat(x)
    1.2499999f0

    julia> bits(prevfloat(x))
    "00111111100111111111111111111111"

    julia> bits(x)
    "00111111101000000000000000000000"

    julia> bits(nextfloat(x))
    "00111111101000000000000000000001"

위의 예제는 서로 이웃한 표현 가능한 부동소수점 수는
바이너리 정수 표기법을 가질 수 있다는 기본적인 원리를 새삼 일깨워 준다.

반올림 모드
~~~~~~~~~~~

만약 어떤 숫자가 정확한 부동소수점 표현을 가지고 있지 않다면,
그 수는 반드시 어떤 표현 가능한 값으로 반올림되어야 한다.
그러나, 만약 사용자가 원한다면,
`IEEE 754 standard <https://en.wikipedia.org/wiki/IEEE_754-2008>`_\ 에
따라 반올림 방식에 대해서는 변경할 수 있다.

.. doctest::

    julia> x = 1.1; y = 0.1;

    julia> x + y
    1.2000000000000002

    julia> setrounding(Float64,RoundDown) do
               x + y
           end
    1.2

기본 반올림 모드는 항상 :const:`RoundNearest`\ 이다.
이는 가장 근접한 표현 가능한 값으로 반올림하되,
만약 두 표현 가능한 값 중간에 주어진 값이 걸쳐 있으면
가수부 값 중 짝수(바이너리이므로 0)로 반올림 하는 모드이다.

.. warning:: 반올림은 일반적으로 기본 산술 함수
         (:func:`+`, :func:`-`, :func:`*`, :func:`/` and :func:`sqrt`)와
         타입 변환 연산에서만 정확하다. 많은 다른 함수들은
         기본 값인 :const:`RoundNearest`\ 를 가정하고 짜여져 있고,
         이는 다른 반올림 모드에서는 부정확한 값을 제공할 수 있다.

부동소수점 실수에 대해서 더 읽으면 좋은 문서들
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

부동소수점 연산은 많은 미묘한 것들을 수반하고 있기 때문에
저수준(low-level) 구현에 익숙하지 않은 유저들은 당황할 수도 있다.
그러나 그 미묘한 점들은 과학적 연산과 관련된 많은 책들에서 잘 설명되고 있고,
아래에 나열하는 참고문헌도 참고하면 좋을 것이다:

- 부동소수점과 관련해서 가장 확실한 가이드는 `IEEE 754-2008
  Standard <http://standards.ieee.org/findstds/standard/754-2008.html>`_\
  이지만, 유료이다.
- 부동소수점이 어떻게 표현되는지에 대한 간략하면서도 명쾌한 설명은
  John D. Cook의 `블로그 글
  <http://www.johndcook.com/blog/2009/04/06/anatomy-of-a-floating-point-number/>`_\ 
  을 참고하면 된다. 같은 주제에 관하여 이와 더불어서 그의
  `소개글 
  <http://www.johndcook.com/blog/2009/04/06/numbers-are-a-leaky-abstraction/>`_\
  글은 부동소수점이 실수의 이상적인 추상화와 다름으로써 생기는
  몇 가지 문제에 대해서도 다루고 있다.
- Bruce Dawson의 `series of blog posts on floating-point
  numbers <https://randomascii.wordpress.com/2012/05/20/thats-not-normalthe-performance-of-odd-floats/>`_\ 도
  추천하는 바이다.
- 상급자들은 부동소수점의 내부 구현에 관한 이야기들과
  부동소수점 연산을 할 때 맞닥뜨릴 수 있는 수치적인 정확도에 관한 문제들에
  대해서는 David Goldberg의 논문, `What Every Computer Scientist Should Know About Floating-Point
  Arithmetic
  <http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.22.6768&rep=rep1&type=pdf>`_\ 을
  참고하는 것이 좋다.
- 부동소수점에 관한 역사, 근원, 몇 가지 이슈들 뿐만 아니라 수치 해석과 관련한
  많은 다양한 이야기들에 대한 자세한 문서를 얻고 싶다면
  `William Kahan <https://en.wikipedia.org/wiki/William_Kahan>`_\ 가 작성한
  `collected writings
  <https://people.eecs.berkeley.edu/~wkahan/>`_\ 을 참고하는 것을 추천한다.
  이 문서는 "부동소수점의 아버지(Father of Floating-Point)"라고도 알려져 있다.
- 특별히 부동소수점의 역사에 관해서 관심이 더 생긴다면,
  `An Interview with the Old
  Man of Floating-Point
  <https://people.eecs.berkeley.edu/~wkahan/ieee754status/754story.html>`_\ 을
  읽기를 바란다.

.. _man-arbitrary-precision-arithmetic:

임의 정밀도 연산
----------------

임의 정밀도의 정수와 부동소수점들의 연산을 위해, Julia는
`GNU Multiple Precision Arithmetic Library (GMP) <https://gmplib.org>`_\ 와
`GNU MPFR Library <http://www.mpfr.org>`_\ 을 각각 래핑(wrapping)하였다
:class:`BigInt`\ 와 :class:`BigFloat` 타입은 Julia에서
각각 임의 정밀도의 정수와 부동소수점을 다루기 위해 사용되고 있다.

기본 수치 타입으로부터 임의 정밀도 정수와 부동소수점 타입을 만들기 위해
생성자가 존재하며, :func:`parse`\ 는 :class:`AbstractString`\ 들로부터
임의 정밀도 타입을 만들 수 있게 해준다.
한번 임의 정밀도 타입이 만들어지면,
:ref:`type promotion and conversion mechanism <man-conversion-and-promotion>`
덕분에 자유롭게 다른 수치타입과 연산을 수행할 수 있다.

.. doctest::

    julia> BigInt(typemax(Int64)) + 1
    9223372036854775808

    julia> parse(BigInt, "123456789012345678901234567890") + 1
    123456789012345678901234567891

    julia> parse(BigFloat, "1.23456789012345678901")
    1.234567890123456789010000000000000000000000000000000000000000000000000000000004

    julia> BigFloat(2.0^66) / 3
    2.459565876494606882133333333333333333333333333333333333333333333333333333333344e+19

    julia> factorial(BigInt(40))
    815915283247897734345611269596115894272000000000

그러나, 기본 타입과 :class:`BigInt`/:class:`BigFloat` 간의
묵시적 형 변환(type promotion)은 자동으로 이루어지지 않고,
반드시 명시적으로 처리되어야 한다.

.. doctest::

    julia> x = typemin(Int64)
    -9223372036854775808

    julia> x = x - 1
    9223372036854775807

    julia> typeof(x)
    Int64

    julia> y = BigInt(typemin(Int64))
    -9223372036854775808

    julia> y = y - 1
    -9223372036854775809

    julia> typeof(y)
    BigInt

:class:`BigFloat` 타입에서 기본 정밀도(가수부의 비트수)와 반올림 모드는
:func:`setprecision`\ 와 :func:`setrounding`\ 를 호출함으로써
변경할 수 있으며, 한 번 호출된 이후에는 그 설정이 계속 유지된다.
특정 블럭의 코드에서만 정밀도와 반올림을 변경하기 위해서는
``do`` 블럭의 코드에서와 같은 함수를 호출한다:

.. doctest::

    julia> setrounding(BigFloat, RoundUp) do
           BigFloat(1) + parse(BigFloat, "0.1")
           end
    1.100000000000000000000000000000000000000000000000000000000000000000000000000003

    julia> setrounding(BigFloat, RoundDown) do
           BigFloat(1) + parse(BigFloat, "0.1")
           end
    1.099999999999999999999999999999999999999999999999999999999999999999999999999986

    julia> setprecision(40) do
           BigFloat(1) + parse(BigFloat, "0.1")
           end
    1.1000000000004


.. _man-numeric-literal-coefficients:

수치형 리터럴 계수
----------------------------

보통의 수학 식과 표현식을 깔끔하게 표현하기 위해서,
Julia는 변수가 수치형 리터럴 바로 다음에 있으면,
둘 사이의 관계가 곱셈임을 가정한다.
이는 다항식의 표현을 더욱 깔끔하게 만든다:

.. doctest::

    julia> x = 3
    3

    julia> 2x^2 - 3x + 1
    10

    julia> 1.5x^2 - .5x + 1
    13.0

이는 지수함수의 포현도 매우 아름답게 만들 수 있다:

.. doctest::

    julia> 2^2x
    64

수치형 리터럴 계수의 선행(precedence)도
부정연산과 같은 단항 연산과 같이 작동한다.
따라서 ``2^3x``\ 는 ``2^(3x)``\ 로,
``2x^3``\ 은 ``2*(x^3)``\ 으로 파싱(parsing)된다.

수치형 리터럴은 괄호가 있는 식에서도 계수(coefficients)로 작동할 수 있다.

.. doctest::

    julia> 2(x-1)^2 - 3(x-1) + 1
    3

게다가 괄호 표현식은 변수 또한 계수로 생각하여,
곱셈기호 없이도 변수들 간의 곱으로 식을 표현할 수도 있다.

.. doctest::

    julia> (x-1)x
    6

그러나 두 괄호식을 병치하거나 괄호식 앞에 변수를 두는 경우는
계수로 사용할 수 없다.

.. doctest::

    julia> (x-1)(x+1)
    ERROR: MethodError: objects of type Int64 are not callable
    ...

    julia> x(x+1)
    ERROR: MethodError: objects of type Int64 are not callable
    ...

두 표현식은 함수로써 인식된다: 괄호앞에 붙는 수치형 리터럴이 아닌
표현식들은 모두 함수와 함수의 매개변수로 인식된다.
(자세한 설명을 위해서는 :ref:`man-functions`\ 를 참고하도록 하자)
그래서 두 가지 경우 모두 왼쪽에 있는 값이 
함수가 아님을 알려주는 에러가 발생한다.

위에서 언급한 문법적 강화효과는 수학식을 작성할 때 생기는 시각적 공해를
줄일 수 있도록 해준다. 단지 한 가지 알아야 할 점은
수치형 계수와 이에 곱해지는 변수 혹은 괄호식등 사이에는
빈칸이 있어서는 안된다.

문법적 충돌
~~~~~~~~~~~

리터럴 계수를 병치하는 문법은
16진수 정수 리터럴과 부동소수점의 공학적 표현라는
두 수치형 리터럴 문법과 충돌이 생길 수 있다
다음은 문법적 충돌이 발생하는 예이다.

16진수 리터럴 표현식 ``0xff``\ 는 수치형 리터럴 ``0``\ 과 변수 ``xff``\ 의
곱셈으로 해석될 수 있다.
부동소수점 리터럴 표현식 ``1e10``\ 은 수치형 리터럴 ``1``\ 이
변수 ``e10``\ 에 곱해지는 걸로 해석될 수 있고 이는 ``e``\ 가 아닌,
``E``\ 를 쓸 때에도 마찬가지이다.

이 두 가지 경우에, 우리는 수치형 리터럴을 해석하는데 있어서
다음과 같은 방식으로 모호함을 해결했다.

- ``0x``\ 로 시작하는 표현식은 항상 16진수 리터럴이다.
- 수치형 리터럴으로 시작하는 표현식에서 수치형 리터럴 다음에 ``e`` 혹은
  ``E``\ 가 뒤따라오면 항상 부동소수점 리터럴이다.

리터럴 0와 1
------------

Julia는 어떤 특정한 타입이나 주어진 변수의 타입에 따라 리터럴 0이나 1을
리턴하는 함수를 제공한다.

====================== =====================================================
함수                   설명
====================== =====================================================
:func:`zero(x) <zero>` ``x`` 타입이나 변수 ``x``\ 의 타입의 리터럴 0
:func:`one(x) <one>`   ``x`` 타입이나 변수 ``x``\ 의 타입의 리터럴 1
====================== =====================================================

위 함수들은 :ref:`man-numeric-comparisons`\ 에서
불필요한 :ref:`type conversion <man-conversion-and-promotion>`\ 에
의한 성능저하를 줄일 때 유용하다.

예제:

.. doctest::

    julia> zero(Float32)
    0.0f0

    julia> zero(1.0)
    0.0

    julia> one(Int32)
    1

    julia> one(BigFloat)
    1.000000000000000000000000000000000000000000000000000000000000000000000000000000
