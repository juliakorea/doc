.. _man-mathematical-operations:

.. currentmodule:: Base

**************************************************
 수학 연산들과 기본적인 함수들
**************************************************

Julia는 모든 수치적 원시타입에 걸친 기본적인 사칙연산과 비트 연산을
완벽하게 지원한다. 그 뿐만이 아니라 포괄적인 표준 수학 함수들을
효율적이고 이식 가능한 형태로 구현하고 있다.

산술 연산자
--------------------

다음의 `arithmetic operators
<https://en.wikipedia.org/wiki/Arithmetic#Arithmetic_operations>`_
는 모든 원시 수치타입에 걸쳐서 사용할 수 있다:

==========  ============== ======================================
표현식      이름           설명
==========  ============== ======================================
``+x``      단항 덧셈      동등 연산 (피연산자를 그대로 반환)
``-x``      단항 뺄셈      피연산자의 부정을 대입한다.
``x + y``   이항 덧셈      덧셈을 수행
``x - y``   이항 뺄셈      뺄셈을 수행
``x * y``   곱셈           곱셈을 수행
``x / y``   나눗셈         나눗셈을 수행
``x \ y``   역수           ``y / x``
``x ^ y``   제곱           ``x``\ 의 ``y``\ 제곱
``x % y``   나머지         ``rem(x,y)``\ 와 같음.
==========  ============== ======================================

``Bool`` 타입의 부정연산 또한 수행할 수 있다:

==========  ============== ============================================
표현식      이름           설명
==========  ============== ============================================
``!x``      부정           ``true`` 를 ``false`` 로 바꾸거나 그 반대의 연산
==========  ============== ============================================

Julia의 프로모션 문법은 다양한 타입간의 산술 연산을 자동으로 자연스럽게 처리할 수 있게 한다.
프로모션 시스템에 관한 자세한 내용은 :ref:`man-conversion-and-promotion`\ 을 참고하는 것이 좋다.

다음은 산술 연산을 이용한 몇 가지 간단한 예제들이다.

.. doctest::

    julia> 1 + 2 + 3
    6

    julia> 1 - 2
    -1

    julia> 3*2/12
    0.5

(일반적으로, 다른 근처의 연산자들보다 먼저 적용되는 연산자들은 피연산자와의 간격을 좀 더 좁게 유지한다.
예를 들어, 일반적으로 ``-x + 2``\ 와 같이 표현하는데,  ``x``\ 가 먼저 음수가 되고, 그 다음에 ``2``\ 가 더해지기 때문에 저런 식으로 표현될 수 있다.)

비트 연산자
-----------------

위키피디아에 명시된 `bitwise
operators <https://en.wikipedia.org/wiki/Bitwise_operation#Bitwise_operators>`_
에 대해서는 모든 원시 정수 타입에 걸쳐서 Julia에서 모두 지원하고 있다.

===========  =========================================================================
표현식       이름
===========  =========================================================================
``~x``       비트 NOT 연산
``x & y``    비트 AND 연산
``x | y``    비트 OR 연산
``x $ y``    비트 XOR 연산 (배타적 OR)
``x >>> y``  오른쪽 방향으로의 `logical shift <https://en.wikipedia.org/wiki/Logical_shift>`_
``x >> y``   오른쪽 방향으로의 `arithmetic shift <https://en.wikipedia.org/wiki/Arithmetic_shift>`_
``x << y``   왼쪽 방향으로의 논리/산술 시프트
===========  =========================================================================

다음은 비트 연산을 이용한 몇 가지 간단한 예제들이다:

.. doctest::

    julia> ~123
    -124

    julia> 123 & 234
    106

    julia> 123 | 234
    251

    julia> 123 $ 234
    145

    julia> ~UInt32(123)
    0xffffff84

    julia> ~UInt8(123)
    0x84

갱신 연산자
------------------
모든 이항 산술 연산자와 비트 연산자는 연산 결과를 왼쪽 피연산자에
다시 대입하는 갱신 연산자 버전이 있다. 이 갱신 연산자는 ``=`` 기호를 
연산자 바로 뒤에 지정함으로써 수행할 수 있다. 
예를 들어, ``x += 3``\ 은 ``x = x + 3``\ 와 같다::

      julia> x = 1
      1

      julia> x += 3
      4

      julia> x
      4

모든 이항 연산과 비트 연산의 갱신 연산자들은 다음과 같다::

    +=  -=  *=  /=  \=  ÷=  %=  ^=  &=  |=  $=  >>>=  >>=  <<=


.. note::
   갱신 연산자는 변수를 좌변으로 다시 바인딩한다. 
   그 결과, 재바인딩되는 변수의 타입이 변할 수 있다.

   .. doctest::

      julia> x = 0x01; typeof(x)
      UInt8

      julia> x *= 2 #Same as x = x * 2
      2

      julia> isa(x, Int)
      true

.. _man-numeric-comparisons:

수치 비교
-------------------

표준 비교 연산은 모든 원시 수치 타입에 관하여 정의되어 있다:

=================== ========================
연산자              이름
=================== ========================
:obj:`==`           같다
:obj:`\!=` :obj:`≠` 같지 않다.
:obj:`<`            작다
:obj:`<=` :obj:`≤`  작거나 같다.
:obj:`>`            크다
:obj:`>=` :obj:`≥`  크거나 같다.
=================== ========================

다음은 몇 가지 간단하 예제들이다:

.. doctest::

    julia> 1 == 1
    true

    julia> 1 == 2
    false

    julia> 1 != 2
    true

    julia> 1 == 1.0
    true

    julia> 1 < 2
    true

    julia> 1.0 > 3
    false

    julia> 1 >= 1.0
    true

    julia> -1 <= 1
    true

    julia> -1 <= -1
    true

    julia> -1 <= -2
    false

    julia> 3 < -0.5
    false

정수는 일반적인 방법으로(비트간의 비교) 비교가능하며, 
부동소수점은 
`IEEE 754 standard <https://en.wikipedia.org/wiki/IEEE_754-2008>`_
에 따라 비교할 수 있다:

- 유한한 수들은 일반적인 방법으로 정렬된다.
- +0은 -0와 같지만 -0보단 크다고 할 수 없다.
- ``Inf`` 는 ``Inf`` 자체와는 같고 ``NaN``\ 을 제외한 어떤 것보다도 크다.
- ``-Inf`` 는 ``-Inf`` 자체와는 같고 ``NaN``\ 을 제외한 어떤 것보다도 작다.
- ``NaN``\ 은 ``NaN`` 자신을 포함하여 어떤 것보다도 같거나 작거나 크지 않다.

마지막 문장을 보고 놀라는 사람도 있을 수 있기 때문에 따로 정리하였다:

.. doctest::

    julia> NaN == NaN
    false

    julia> NaN != NaN
    true

    julia> NaN < NaN
    false

    julia> NaN > NaN
    false

그리고 이 점은 :ref:`Arrays <man-arrays>`\ 를 다룰 때 골치 아픈 일이 될 수 있다.

.. doctest::

    julia> [1 NaN] == [1 NaN]
    false

Julia는 해시 키 비교와 같은 상황에서 유용한 숫자 테스트용 함수를 
몇 가지 제공한다:

=============================== =================================================
함수                            테스트 항목
=============================== =================================================
:func:`isequal(x, y) <isequal>` ``x``\ 와 ``y``\ 가 같은지에 대한 여부
:func:`isfinite(x) <isfinite>`  ``x``\ 가 유한한지에 대한 여부
:func:`isinf(x) <isinf>`        ``x``\ 가 무한한지에 대한 여부
:func:`isnan(x) <isnan>`        ``x``\ 가 수가 아닌지(``NaN``\ 인지)에 대한 여부
=============================== =================================================

:func:`isequal`\ 는 ``NaN``\ 끼리는 서로 같다고 간주한다.

.. doctest::

    julia> isequal(NaN,NaN)
    true

    julia> isequal([1 NaN], [1 NaN])
    true

    julia> isequal(NaN,NaN32)
    true

:func:`isequal`\ 는 부호 있는 0을 구별할 때도 쓸 수 있다:

.. doctest::

    julia> -0.0 == 0.0
    true

    julia> isequal(-0.0, 0.0)
    false


타입이 섞여 있을 때의 비교(부호 있는 정수, 부호 없는 정수, 그리고 실수 간의 비교)는
헷갈릴 수 가 있다.
Julia가 비교 연산을 정확히 할 수 있도록 보장하기 위해서 이 연산은 매우 조심히 해야한다.

다른 타입의 경우에는 :func:`isequal`\ 는 :func:`==`\ 와 같기 때문에, 
만약 사용자에 의해 정의된 타입 간의 비교를 추가하고 싶으면 
:func:`==`\ 메소드만 새로 추가해주면 된다.
만약 동등 비교 연산을 새로 추가하고자 한다면, 
그에 상응하는 :func:`hash`\ 메소드를 추가하여 ``isequal(x,y)``\ 이
``hash(x) == hash(y)``\ 를 내포할 수 있도록 해야한다.

비교 연산의 중첨
~~~~~~~~~~~~~~~~~~~~

Python(`notable exception of
Python <https://en.wikipedia.org/wiki/Python_syntax_and_semantics#Comparison_operators>`_\ )
을 포함한 다른 언어와는 달리 Julia에서는 비교 연산이 임의적으로 중첩할 수 있다:

.. doctest::

    julia> 1 < 2 <= 2 < 3 == 3 > 2 >= 1 == 1 < 3 != 5
    true

비교 연산의 중첩은 수치 코드에서 종종 그 위력을 발휘한다.
비교 연산 중첩에서 스칼라 값의 비교는 :obj:`&&` 연산자를 쓰고, 
배열이나 행렬 등에서의 항목간 비교는 :obj:`&`\ 를 쓴다.
예를 들어, ``0 .< A .< 1``\ 는 ``A`` 배열에서 0과 1 사이의 값을 가졌을 때만 
``true`` 값을 가지는 boolean 배열을 리턴한다.

:obj:`.\< <Base..\<>`는 배열 간에 비교를 위해 작동하도록 만들어진 연산자이다; ``A .< B`` 연산은
``A``\ 와 ``B`` 가 같은 dimension일 때만 유효하다.
이 연산자는 ``A``\ 나 ``B``\ 와 같은 dimension을 지닌 boolean 배열을 리턴한다. 
이런 연산을 일컫어 *항목간 비교 연산자(elementwise)*\ 라고 한다; 
Julia는 :obj:`.<` 이외에도 :obj:`.* <Base..*>`, :obj:`.+ <Base..+>` 등의 항목간 비교 연산자를 제공한다.
몇몇 항목간 비교 연산자는 바로 전 단락에서도 언급한 ``0 .< A .< 1``\ 와 같이
스칼라 값을 피연산자로 받기도 한다. 스칼라 값이 피연산자로 될 경우에는 스칼라 값이
배열의 각 항목으로 복제되어 들어간다는 의미이다.

다음은 중첩된 비교 연산이 어떻게 평가되어지는지 나타낸다::

.. doctest::

    julia> v(x) = (println(x); x)
    v (generic function with 1 method)

    julia> v(1) < v(2) <= v(3)
    2
    1
    3
    true

    julia> v(1) > v(2) <= v(3)
    2
    1
    false

가운데에 있는 표현식은 ``v(1) < v(2) && v(2) <= v(3)`` 와 같이 
두 번 평가되는 것 이 아니라 딱 한번만 평가된다.
그러나, 중첩 비교 연산 시의 순서는 따로 정의되지 않았다.
출력과 같이 부수적인 효과가 있는 표현식은 중첩 비교 연산에서 쓰지 않는 것이 바람직하다.
그러나 어쩔 수 없이 부수적인 효과가 들어있는 표현식을 써야만 한다면,
:obj:`&&` 연산자를 써서 명시적으로 비교 연산을 수행해야 한다.
(:ref:`man-short-circuit-evaluation` 참고).

연산자 우선순위
~~~~~~~~~~~~~~~~~~~

Julia는 다음과 같은 순서로 연산을 수행한다. (높은 우선순위부터 낮은 우선순위로 표기):

================= =============================================================================================
분류              연산자
================= =============================================================================================
문법              ``.``, ``::``
지수              ``^``, ``.^`` (항목 간의 연산)
분수              ``//``, ``.//``
곱셈              ``* / % & \``, 그리고 ``.* ./ .% .\``
비트 이동         ``<< >> >>>``, 그리고 ``.<< .>> .>>>``
덧셈              ``+ - | $``, 그리고 ``.+ .-``
문법              ``: ..``, ``|>``
비교              ``> < >= <= == === != !== <:``, 그리고 ``.> .< .>= .<= .== .!=``
제어 흐름         ``&&``, ``||``, ``?``
대입              ``= += -= *= /= //= \= ^= ÷= %= |= &= $= <<= >>= >>>=``, 그리고 ``.+= .-= .*= ./= .//= .\= .^= .÷= .%=``
================= =============================================================================================

.. _man-elementary-functions:

기초 함수
~~~~~~~~~~~~~~~~~~~~

Julia는 수학 함수와 연산자의 종합 콜렉션을 제공하고 있다. 이런 수학적 연산은
정수, 부동소수점 실수, 유리수, 복소수를 비롯한 어떠한 합당한 수학적 정의에 의한 수에
대해서도 정의할 수 있다.

게다가, 이런 함수들은 (Julia의 다른 함수들과 같은) "벡터화"된 형태를 취하여
``f.(A)`` 와 같은 문법을 이용하여
배열이나 다른 컬렉션들과 함께 적용될 수 있다.
예를 들어, ``sin.(A)``\ 은 배열 ``A``\ 의 각각의 원소에 대해
사인값을 계산할 수 있게 한다.
자세한 내용은 :ref:`man-dot-vectorizing`\ 을 참고하면 알 수 있다:

.. _man-numerical-conversions:

수치 변환
---------------------

Julia는 부정확한 변환에 있어서 서로 차이가 발생하는 총 세 가지 형태의 수치변환을 제공한다.

- ``T(x)`` 혹은 ``convert(T,x)``\ 의 형태는 어떤 값 ``x``\ 를 타입 ``T``\ 로 변환한다.

  -  만약 ``T``\ 가 부동 소수점 타입이라면, 결과물은 표현가능한 가장 가까운 값으로 표현될 것이며,
     그 값 중에는 ``+Inf`` 혹은 ``-Inf``\ 가 포함 될 수 있다.

  -  만약 ``T``\ 가 정수 타입이라면, ``x``\ 가 ``T`` 타입에 의해 표현되지 않을 때 
     ``InexactError``\ 가 발생할 것이다.


- ``x % T``\ 는 ``n``\ 이 ``T`` 타입의 비트수일 때, 정수 ``x``\ 와 ``2^n``\ 의 
  나머지를 타입 ``T``\ 로 변환할 것이다. 다시 말해서, 바이너리 표현에 의해 특정 부분이
  무시될 수도 있다.

- :ref:`man-rounding-functions`\ 는 타입 ``T``\ 를 부수적인 매개변수로 받는다.
  예를 들어, ``round(Int,x)``\ 는 ``Int(round(x))``\ 의 단축형 표현이다.

다음 예제는 위의 세 가지 형태의 수치 변환을 보여준다.

.. doctest::

    julia> Int8(127)
    127

    julia> Int8(128)
    ERROR: InexactError()
     in Int8(::Int64) at ./sysimg.jl:53
     ...

    julia> Int8(127.0)
    127

    julia> Int8(3.14)
    ERROR: InexactError()
     in Int8(::Float64) at ./sysimg.jl:53
     ...

    julia> Int8(128.0)
    ERROR: InexactError()
     in Int8(::Float64) at ./sysimg.jl:53
     ...

    julia> 127 % Int8
    127

    julia> 128 % Int8
    -128

    julia> round(Int8,127.4)
    127

    julia> round(Int8,127.6)
    ERROR: InexactError()
     in trunc(::Type{Int8}, ::Float64) at ./float.jl:456
     in round(::Type{Int8}, ::Float64) at ./float.jl:211
     ...

:ref:`man-conversion-and-promotion`\ 을 참고하면 사용자 정의 변한과 프로모션을 
어떻게 정의하는 지 알 수 있다.

.. _man-rounding-functions:

근사 함수
~~~~~~~~~~~~~~~~~~

=========================== ================================== =============
함수                        설명                               리턴 값
=========================== ================================== =============
:func:`round(x) <round>`    ``x``\ 와 가까운 정수로 근사       ``typeof(x)``
:func:`round(T, x) <round>` ``x``\ 와 가까운 정수로 근사       ``T``
:func:`floor(x) <floor>`    ``x``\ 를 ``-Inf`` 방향으로 근사   ``typeof(x)``
:func:`floor(T, x) <floor>` ``x``\ 를 ``-Inf`` 방향으로 근사   ``T``
:func:`ceil(x) <ceil>`      ``x``\ 를 ``+Inf`` 방향으로 근사   ``typeof(x)``
:func:`ceil(T, x) <ceil>`   ``x``\ 를 ``+Inf`` 방향으로 근사   ``T``
:func:`trunc(x) <trunc>`    ``x``\ 를 ``0``\ 을 향해 근사      ``typeof(x)``
:func:`trunc(T, x) <trunc>` ``x``\ 를 ``0``\ 을 향해 근사      ``T``
=========================== ================================== =============

나눗셈 함수
~~~~~~~~~~~~~~~~~~

============================ =======================================================================
함수                         설명
============================ =======================================================================
:func:`div(x,y) <div>`       반올림 나눗셈; 몫이 ``0``\ 을 향해 근사
:func:`fld(x,y) <fld>`       내림 나눗셈; 몫이 ``-Inf``\ 을 향해 근사
:func:`cld(x,y) <cld>`       올림 나눗셈; 몫이 ``+Inf``\ 을 향해 근사
:func:`rem(x,y) <rem>`       나머지; ``x == div(x,y)*y + rem(x,y)``\ 를 만족; ``x``\ 의 부호와 같다. 
:func:`mod(x,y) <mod>`       나머지; ``x == fld(x,y)*y + mod(x,y)``\ 를 만족; ``y``\ 의 부호와 같다.
:func:`mod1(x,y) <mod1>`     오프셋 1이 적용된 ``mod()`` 함수; ``mod(r, y) == mod(x, y)``\ 일 때,  ``y>0``\ 의 경우에는 ``r∈(0,y]``\ 을, ``y<0``\ 의 경우에는 ``r∈[y,0)``\ 을 반환한다.
:func:`mod2pi(x) <mod2pi>`   2pi에 대한 나머지;  ``0 <= mod2pi(x)  < 2pi``
:func:`divrem(x,y) <divrem>` ``(div(x,y),rem(x,y))``\ 를 반환 
:func:`fldmod(x,y) <fldmod>` ``(fld(x,y),mod(x,y))``\ 를 반환
:func:`gcd(x,y...) <gcd>`    ``x``, ``y``,...\ 의 최대 공약수
:func:`lcm(x,y...) <lcm>`    ``x``, ``y``,...\ 의 최소 공배수
============================ =======================================================================

부호와 절대값 관련 함수
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

================================ ===========================================================
함수                             설명
================================ ===========================================================
:func:`abs(x) <abs>`             ``x``\ 의 크기를 가지는 양수
:func:`abs2(x) <abs2>`           ``x``\ 의 크기의 제곱근
:func:`sign(x) <sign>`           ``x``\ 의 부호, -1, 0, 혹은 +1을 반환
:func:`signbit(x) <signbit>`     부호 비트가 켜져있는 지의 여부를 알려줌
:func:`copysign(x,y) <copysign>` ``x``\ 의 값을 지니면서 ``y``\ 의 부호를 반환
:func:`flipsign(x,y) <flipsign>` ``x``\ 의 값을 지니면서 ``x*y``\ 의 부호를 반환
================================ ===========================================================

지수, 로그 그리고 제곱근에 관련한 함수
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

==================================== ================================================================================
함수                                 설명
==================================== ================================================================================
:func:`sqrt(x) <sqrt>` ``√x``        ``x``\ 의 제곱근
:func:`cbrt(x) <cbrt>` ``∛x``        ``x``\ 의 삼중 제곱근
:func:`hypot(x,y) <hypot>`           직각 삼각형에서 직각에 인접한 변의 길이가 ``x``\ 와 ``y``\ 일 때의 빗면의 길이
:func:`exp(x) <exp>`                 ``x``\ 의 자연 지수 함수 (exponential)
:func:`expm1(x) <expm1>`             0 근처의 ``x`` 값에 대한 정확한 ``exp(x)-1`` 값
:func:`ldexp(x,n) <ldexp>`           정수 ``n``\ 에 대해 ``x*2^n``\ 를 효율적으로 계산
:func:`log(x) <log>`                 ``x``\ 의 자연로그
:func:`log(b,x) <log>`               ``b``\ 를 밑으로 하는 ``x``\ 의 로그값
:func:`log2(x) <log2>`               2를 밑으로 하는 ``x``\ 의 로그값
:func:`log10(x) <log10>`             10을 밑으로 하는 ``x``\ 의 로그값(상용로그)
:func:`log1p(x) <log1p>`             0 근처의 ``x`` 값에 대한 정확한 ``log(1+x)`` 값
:func:`exponent(x) <exponent>`       부동소수점 ``x``\ 의 지수부 값
:func:`significand(x) <significand>` 부동소수점 ``x``\ 의 가수부 값
==================================== ================================================================================

:func:`hypot`, :func:`expm1`, 그리고 :func:`log1p` 와 같은 함수들이 필수적이고 유용하지 알고 싶다면,
John D. Cooks 이 블로그 글을 참조하면 쉽게 이해할 수 있다: 
`expm1, log1p, erfc <http://www.johndcook.com/blog/2010/06/07/math-library-functions-that-seem-unnecessary/>`_, 
`hypot <http://www.johndcook.com/blog/2010/06/02/whats-so-hard-about-finding-a-hypotenuse/>`_.

삼각함수와 포물선 함수
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Julia에서는 모든 표준 삼각함수들과 포물선 함수들이 정의되어 있다::

    sin    cos    tan    cot    sec    csc
    sinh   cosh   tanh   coth   sech   csch
    asin   acos   atan   acot   asec   acsc
    asinh  acosh  atanh  acoth  asech  acsch
    sinc   cosc   atan2

`atan2 <https://en.wikipedia.org/wiki/Atan2>`_\ 을 제외한 이 함수들은
모두 매개변수가 하나이다. 
참고로 `atan2 <https://en.wikipedia.org/wiki/Atan2>`_\ 는 *x* 축과
매개변수로 제공하는 (*x*, *y*)라는 좌표 간의 각도를 
`radians <https://en.wikipedia.org/wiki/Radian>`_ 단위로 반환하는 함수이다.

추가적으로, :func:`sinpi(x) <sinpi>`\ 와 :func:`cospi(x) <cospi>` 는 
:func:`sin(pi*x) <sin>` and :func:`cos(pi*x) <cos>`\ 의 좀 더 정확한 버전이다.

삼각함수를 계산할 때 라디안 대신에 각도를 이용해서 쓰고 싶다면,
기존의 삼각함수 명칭 뒤에 ``d``\ 를 붙이면 된다.
예를 들어, :func:`sind(x) <sind>`\ 는 ``x``\ 가 각도로 표시될 때의 사인(sine)값을 계산한다.
모든 삼각함수의 각도버전 리스트는 다음과 같다::

    sind   cosd   tand   cotd   secd   cscd
    asind  acosd  atand  acotd  asecd  acscd

특별한 함수
~~~~~~~~~~~~~~~~~

=================================================== ==============================================================================
함수                                                설명
=================================================== ==============================================================================
:func:`erf(x) <erf>`                                ``x``\ 에서의 `error function <https://en.wikipedia.org/wiki/Error_function>`_
:func:`erfc(x) <erfc>`                              상보 오차함수, 즉 큰 ``x``\ 에서의 보다 정확한 ``1-erf(x)``.
:func:`erfinv(x) <erfinv>`                          :func:`erf`\ 의 역함수
:func:`erfcinv(x) <erfinvc>`                        :func:`erfc`\ 의 역함수
:func:`erfi(x) <erfi>`                              :const:`im`\ 가 허수 단위 *i*\ 일 때, ``-im * erf(x * im)``\ 로 정의되어진 허수 오차함수
:func:`erfcx(x) <erfcx>`                            스케일링된 상보 오차함수, 즉 큰 ``x``\ 에서의 보다 정확한 ``exp(x^2) * erfc(x)``.
:func:`dawson(x) <dawson>`                          스케일링된 허수 오차함수, 다시 말해 Dawson 함수, 즉 큰 ``x``\ 에서의 보다 정확한 ``exp(-x^2) * erfi(x) * sqrt(pi) / 2``.
:func:`gamma(x) <gamma>`                            ``x``\ 에서의 `gamma function <https://en.wikipedia.org/wiki/Gamma_function>`_
:func:`lgamma(x) <lgamma>`                          큰 ``x``\ 에서의 정확한 ``log(gamma(x))``
:func:`lfact(x) <lfact>`                            큰 ``x``\ 에서의 정확한 ``log(factorial(x))``; ``x > 1`` 일 때 ``lgamma(x+1)``\ 이며, 다른 경우에는 0
:func:`digamma(x) <digamma>`                        ``x``\ 에서의 `digamma function <https://en.wikipedia.org/wiki/Digamma_function>`_ (예를 들어 :func:`lgamma`)
:func:`beta(x,y) <beta>`                            ``x,y``\ 에서의 `beta function <https://en.wikipedia.org/wiki/Beta_function>`_
:func:`lbeta(x,y) <lbeta>`                          큰 ``x``\ 혹은 ``y``\ 에서의 accurate ``log(beta(x,y))``
:func:`eta(x) <eta>`                                ``x``\ 에서의 `Dirichlet eta function <https://en.wikipedia.org/wiki/Dirichlet_eta_function>`_
:func:`zeta(x) <zeta>`                              ``x``\ 에서의 `Riemann zeta function <https://en.wikipedia.org/wiki/Riemann_zeta_function>`_
|airylist|                                          ``z``\ 에서의 `Airy Ai function <https://en.wikipedia.org/wiki/Airy_function>`_
|airyprimelist|                                     ``z``\ 에서의 Airy Ai function의 미분
:func:`airybi(z) <airybi>`, ``airy(2,z)``           ``z``\ 에서의 `Airy Bi function <https://en.wikipedia.org/wiki/Airy_function>`_
:func:`airybiprime(z) <airybiprime>`, ``airy(3,z)`` ``z``\ 에서의 Airy Bi function의 미분
:func:`airyx(z) <airyx>`, ``airyx(k,z)``            ``z``\ 에서의 스케일링 된 Airy AI function의 ``k``\ 차 미분
:func:`besselj(nu,z) <besselj>`                     ``z``\ 에서의  ``nu``\ 차 제1종 `Bessel function <https://en.wikipedia.org/wiki/Bessel_function>`_ (``J_a``)
:func:`besselj0(z) <besselj0>`                      ``besselj(0,z)``
:func:`besselj1(z) <besselj1>`                      ``besselj(1,z)``
:func:`besseljx(nu,z) <besseljx>`                   ``z``\ 에서의 ``nu``\ 차 스케일링된 제1종 Bessel function(``J_a``) 
:func:`bessely(nu,z) <bessely>`                     ``z``\ 에서의 ``nu``\ 차 제2종 `Bessel function <https://en.wikipedia.org/wiki/Bessel_function>`_ (``Y_a``)
:func:`bessely0(z) <bessely0>`                      ``bessely(0,z)``
:func:`bessely1(z) <bessely0>`                      ``bessely(1,z)``
:func:`besselyx(nu,z) <besselyx>`                   ``z``\ 에서의 ``nu``\ 차 제2종 스케일링된 Bessel function(``Y_a``)
:func:`besselh(nu,k,z) <besselh>`                   ``z``\ 에서의 ``nu``\ 차 제3종 `Bessel function <https://en.wikipedia.org/wiki/Bessel_function>`_ (``H_a``, Hankel function이라고도 불리움) ; ``k``\ 는 ``1`` 혹은 ``2`` 이어야만 한다.
:func:`hankelh1(nu,z) <hankelh1>`                   ``besselh(nu, 1, z)``
:func:`hankelh1x(nu,z) <hankelh1x>`                 스케일링된 ``besselh(nu, 1, z)``
:func:`hankelh2(nu,z) <hankelh2>`                   ``besselh(nu, 2, z)``
:func:`hankelh2x(nu,z) <hankelh2x>`                 스케일링된 ``besselh(nu, 2, z)``
:func:`besseli(nu,z) <besseli>`                     ``z``\ 에서의 ``nu``\ 차 제1종 변형 `Bessel function <https://en.wikipedia.org/wiki/Bessel_function>`_ (``I_a``)
:func:`besselix(nu,z) <besselix>`                   ``z``\ 에서의 ``nu``\ 차 제1종 스케일링된 변형 Bessel function
:func:`besselk(nu,z) <besselk>`                     ``z``\ 에서의 ``nu``\ 차 제2종 변형 `Bessel function <https://en.wikipedia.org/wiki/Bessel_function>`_ (``K_a``)
:func:`besselkx(nu,z) <besselkx>`                   ``z``\ 에서의 ``nu``\ 차 제2종 스케일링된 변형 Bessel function
=================================================== ==============================================================================

.. |airylist| replace:: :func:`airy(z) <airy>`, :func:`airyai(z) <airyai>`, ``airy(0,z)``
.. |airyprimelist| replace:: :func:`airyprime(z) <airyprime>`, :func:`airyaiprime(z) <airyaiprime>`, ``airy(1,z)``
