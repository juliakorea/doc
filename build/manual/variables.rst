
***********
 변수
***********

Julia에서 변수는 값에 연관된 (혹은 한정되는) 이름을 말한다.
변수는 나중에 사용할 용도로 값(예를 들면, 수학 연산을 통해 얻어진 값)을
저장할 때 유용하다. 예를 들면:

.. doctest::

    # 변수 x에 10이라는 값을 지정한다.
    julia> x = 10
    10

    # 변수 x의 값을 이용하여 어떤 연산을 수행한다.
    julia> x + 1
    11

    # 다시 x에 값을 지정한다.
    julia> x = 1 + 1
    2

    # 변수에 문자열과 같이 다른 타입의 값을 지정할 수도 있다.
    julia> x = "Hello World!"
    "Hello World!"

Julia는 변수의 이름을 지정하는데 있어서 매우 유연하다.
변수의 이름은 대소문자를 구별하며, 어떤 특정한 의미를 부여하지 않는다.
(변수의 이름이 특별하다고 해서
Julia가 변수들 다른 방식으로 다루지 않는다)

.. doctest::

    julia> x = 1.0
    1.0

    julia> y = -3
    -3

    julia> Z = "My string"
    "My string"

    julia> customary_phrase = "Hello world!"
    "Hello world!"

    julia> UniversalDeclarationOfHumanRightsStart = "人人生而自由，在尊严和权利上一律平等。"
    "人人生而自由，在尊严和权利上一律平等。"

변수명에 유니코드 문자열도 (UTF-8 인코딩을 따름) 허용한다:

.. doctest::

    julia> δ = 0.00001
    1.0e-5

    julia> 안녕하세요 = "Hello"
    "Hello"

Julia 대화형 실행환경 혹은 다른 Julia 편집 환경에서는,
유니코드로 지정되어 있는
백슬래시로 표현되는 LaTex 기호들을 tab과 함께 입력할 수 있다.
예를 들면, 변수명 ``δ``\ 는 ``\delta``-\ *tab*\ 로,
``α̂₂`` 는
``\alpha``-\ *tab*\ -``\hat``-\ *tab*\ -``\_2``-\ *tab*\ 로
표현할 수 있다.

Julia는 기본 상수나 함수조차도 필요하면 다시 정의할 수 있다.

.. doctest::

    julia> pi
    π = 3.1415926535897...

    julia> pi = 3
    WARNING: imported binding for pi overwritten in module Main
    3

    julia> pi
    3

    julia> sqrt(100)
    10.0

    julia> sqrt = 4
    WARNING: imported binding for sqrt overwritten in module Main
    4

하지만 위 방법은 혼란을 줄 수 있기 때문에 추천하지 않는다.

변수명의 허용범위
=================

변수명은 영문 대소문자 (A-Z 혹은 a-z), 밑줄,
혹은 00A0이상의 코드표를 지니는 유니코드 글자로 시작해야한다;
자세히 이야기하면, `Unicode character categories`_
Lu/Ll/Lt/Lm/Lo/Nl (글자), Sc/So (통화 및 다른 기호),
그리고 다른 몇 가지의 문자같은 기호들도 (예를 들어 Sm 수학기호) 허용한다.
첫 글자 다음은 !(느낌표)와
숫자 (0-9와 Nd/No 카테고리에 포함되는 문자들) 뿐만 아니라,
다른 유니코드 문자들도 변수명으로 허용한다:여기에는 변수명 허용범위에
발음기호 및 다른 수정기호(Mn/Mc/Me/Sk),
몇몇 구두점 접속사 (Pc 카테고리), prime 기호들,
그리고 몇 가지 다른 기호들을 포함한다는 것을 뜻한다.

.. _Unicode character categories: http://www.fileformat.info/info/unicode/category/index.htm

``+``\ 와 같은 기호들을 변수명으로 허용되지만,
Julia가 특별한 방식으로 파싱(parsing)한다.
어떤 경우에는, 연산자들은 일반적인 변수처럼 취급될 수도 있다;
예를 들면 ``(+)``\ 는 덧셈 함수처럼 인식되어,
``(+) = f``\ 와 같이 정의할 수 있다.
Sm 카테고리에 있는 대부분의 유니코드 중위기호(infix)들은
중위 연산자(infix operator)로
파싱(parsing)되며 사용자가 새롭게 정의할 수 있다.
(예를 들어 ``const ⊗ = kron``\ 와 같이
중위 크로네커 곱셈을 ``⊗``\ 로 정의할 수 있다.)

Julia에서 변수명으로 허용이 안되는 이름들은 내장 구문들 뿐이다.

.. doctest::

    julia> else = false
    ERROR: syntax: unexpected "else"
     ...

    julia> try = "No"
    ERROR: syntax: unexpected "="
     ...


코딩 컨벤션
===========

Julia가 변수명에 제한이 별로 없더라도 다음과 같은 관습을 따르는 것이 좋다.

- 변수명은 소문자로 한다.
- 변수명 내의 단어 구분은 밑줄로써 표현될 수 있지만,
  밑줄(``'_'``)은 최대한 안쓰는 것이 좋다.
  (단어가 구분이 안되서 변수명을 읽기 힘들때만 밑줄을 쓰도록 한다.)
- ``Type``\ 과 ``Modules``\ 이름은 대문자로 시작하고
  단어 구분은 밑줄 대신에 대문자로 시작하는
  카멜표기법을 따른다.
- ``function``\ 과 ``macro``\ 의 이름은 밑줄 없는 소문자가 좋다.
- 매개변수를 수정하는 함수들의 이름은 ``!``\ 로 끝내는 것이 좋다.
  이는 "mutation" 함수나 "in-place" 함수라고 불리우는 것인데,
  이 함수들은 실행했을 때 단순히 어떤 값을 리턴하는 것이 아니라,
  입력값(매개변수)를 변화시키기 때문이다.
