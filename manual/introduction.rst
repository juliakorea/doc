.. _man-introduction:

**************
 Introduction
 소개 글
**************

과학 분야의 컴퓨팅은 통상적으로 높은 성능을 필요로 하는데
그 분야 전문가들은 속도가 떨어짐에도 동적인 언어로 넘어와 그 업무를 처리한다.
응용 분야에서 동적 언어를 선호하는 것에는 그럴만한 이유가 있을 것이며
우리가 보기에 그런 현상이 줄어들 것 같지는 않다.
  Scientific computing has traditionally required the highest performance,
  yet domain experts have largely moved to slower dynamic languages for
  daily work. We believe there are many good reasons to prefer dynamic
  languages for these applications, and we do not expect their use to
  diminish. 

다행히 근래의 언어 디자인과 컴파일러 기법들은
성능을 포기했던 지점들을 제거함으로써
프로토타이핑 시 개별 환경의 생산성을 제공하고
성능을 중시하는 애플리케이션 구축 시 그 실효성을 갖출 수 있게 한다.
  Fortunately, modern language design and compiler techniques
  make it possible to mostly eliminate the performance trade-off and
  provide a single environment productive enough for prototyping and
  efficient enough for deploying performance-intensive applications.

줄리아 프로그래밍 언어는 이런 역할을 맡는다:
과학과 수학 분야의 컴퓨팅에 적합한,
기존의 정적 타입 언어에 견줄만한 성능을 갖춘 유연한 동적 언어.
  The Julia programming language fills this role: it is a flexible dynamic
  language, appropriate for scientific and numerical computing, with
  performance comparable to traditional statically-typed languages.

때문에 줄리아 컴파일러는
파이썬 R과 같은 언어에서 사용하는 인터프리터와 다르다.
줄리아의 성능을 보면 처음엔 상식적으로 요상하다.
만약 작성한 코드가 왠지 느리게 돌아간다면 다른 것보다 우선 "성능 향상 팁"을 읽어보길 권한다.
줄리아가 어떤 식으로 작동하는지 이해하였다면
C만큼 빠른 코드의 작성은 한결 수월해질 것이다.
  Because Julia's compiler is different from the interpreters used
  for languages like Python or R, you may find that Julia's performance
  is unintuitive at first. If you find that something is slow, we highly
  recommend reading through the :ref:`man-performance-tips`
  section before trying anything else. Once you understand how Julia
  works, it's easy to write code that's nearly as fast as C.

줄리아는 타입 추론과 LLVM으로 구현한 적시 컴파일(JIT)을 통해 이룬
선택적 타입, 멀티플 디스패치(함수 이름은 같지만 타입이 다른), 좋은 성능을 지니고 있다.
그리고 명령형, 함수형, 객체 지향 프로그래밍에서의 특징을 모아놓은 여러가지 패러다임을 추구한다.
  Julia features optional typing, multiple dispatch, and good
  performance, achieved using type inference and `just-in-time (JIT)
  compilation <http://en.wikipedia.org/wiki/Just-in-time_compilation>`_,
  implemented using `LLVM
  <http://en.wikipedia.org/wiki/Low_Level_Virtual_Machine>`_. It is
  multi-paradigm, combining features of imperative, functional, and
  object-oriented programming.

줄리아는 상위 레벨 수치 계산에 있어 
R 매트랩 파이썬과 같은 언어처럼 쉬우면서도 뛰어난 표현력을 가진다.
뿐만 아니라 일반적인 프로그래밍도 지원한다.
이를 위해 수학용 프로그래밍 언어를 기원으로 구축되었고
리스프 펄 파이썬 루아 루비와 같은 인기 많은 동적 언어들을 취합하고 있다.
  Julia provides ease and expressiveness for high-level numerical computing, in the same way as languages such
  as R, MATLAB, and Python, but also supports general programming. To
  achieve this, Julia builds upon the lineage of
  mathematical programming languages, but also borrows much from popular
  dynamic languages, including `Lisp
  <http://en.wikipedia.org/wiki/Lisp_(programming_language)>`_, `Perl
  <http://en.wikipedia.org/wiki/Perl_(programming_language)>`_, `Python
  <http://en.wikipedia.org/wiki/Python_(programming_language)>`_, `Lua
  <http://en.wikipedia.org/wiki/Lua_(programming_language)>`_, and `Ruby
  <http://en.wikipedia.org/wiki/Ruby_(programming_language)>`_.

기존의 동적 언어와 비교해 줄리아가 특출난 점은:
- 핵심 언어는 작게 꾸린다; 
  정수를 다루는 프리미티브 연산자(+ - * 같은)를 비롯하여 기본 라이브러리는 줄리아 자체로 작성되었다.
- 타입을 구성하고 객체를 서술하기가 언어적으로 풍부하다, 타입 선언을 만들 때에도 선택적으로 사용할 수 있다.
- 인자 타입을 조합함으로서 함수의 작동 행위를 정의하는 "멀티플 디스패치"
- 인자 타입에 따라 효율적이고 특화된 코드를 자동으로 생성
- C처럼 정적으로 컴파일되는 언어에 근접한 좋은 성능
  The most significant departures of Julia from typical dynamic languages
are:
  -  The core language imposes very little; the standard library is
     written in Julia itself, including primitive operations like integer
     arithmetic
  -  A rich language of types for constructing and describing objects,
     that can also optionally be used to make type declarations
  -  The ability to define function behavior across many combinations of
     argument types via `multiple
     dispatch <http://en.wikipedia.org/wiki/Multiple_dispatch>`_
  -  Automatic generation of efficient, specialized code for different
     argument types
  -  Good performance, approaching that of statically-compiled languages
     like C

이따금 동적 언어에 대해 "타입이 없다"는 식으로 말을 하지만 절대 그렇지 않다:
프리미티브(숫자와 같은 기본 타입의)이거나 별도로 정의하는 것을 통틀어 모든 객체는 타입을 가진다.
그러나 대부분의 동적 언어는 타입 선언이 부족하여 컴파일러가 해당 값의 타입을 인지하지 못한다거나
꽤 자주 타입에 대해 명시적으로 밝힐 수 없는 상태가 되곤 한다.
한편 정적 언어는 - 보통 반드시 - 컴파일러에게 타입이 뭔지 주석을 달아 
타입은 오직 컴파일 시에만 존재해 실행시에는 이를 다루거나 표현할 수가 없다.
줄리아에서 타입은 그 자체가 런타임 객체이며 컴파일러에게 정보를 전달하는 용도로도 쓰인다.
  Although one sometimes speaks of dynamic languages as being "typeless",
  they are definitely not: every object, whether primitive or
  user-defined, has a type. The lack of type declarations in most dynamic
  languages, however, means that one cannot instruct the compiler about
  the types of values, and often cannot explicitly talk about types at
  all. In static languages, on the other hand, while one can — and usually
  must — annotate types for the compiler, types exist only at compile time
  and cannot be manipulated or expressed at run time. In Julia, types are
  themselves run-time objects, and can also be used to convey information
  to the compiler.

(특별한 신경을 쓰지 않아도 괜찮은) 일상의 프로그래머에겐 타입의 명시나
멀티플 디스패치란게 필요하지 않겠지만 줄리아의 특징들을 이어주는 핵심은 바로:
함수들은 서로 다른 인자 타입들을 조합함으로서 정의되고
가장 그 정의와 맞물리는 타입을 찾아 디스패치하여 실행된다.
이 모델은 수학용 프로그래밍과 잘 맞는데,
객체 지향에서는 첫번째 인자가 연산자를 "소유"하는 방식으로 디스패치하기에 부자연스럽다.
연산자는 단지 특별히 표기한 함수일 뿐이다 - ``+`` 함수에 새로운 데이터 타입을 정의했을 경우
추가로 메서드를 정의하면 된다. 기존 코드는 새로운 데이터 타입과 맞물려 원할히 작동한다.
  While the casual programmer need not explicitly use types or multiple
  dispatch, they are the core unifying features of Julia: functions are
  defined on different combinations of argument types, and applied by
  dispatching to the most specific matching definition. This model is a
  good fit for mathematical programming, where it is unnatural for the
  first argument to "own" an operation as in traditional object-oriented
  dispatch. Operators are just functions with special notation — to extend
  addition to new user-defined data types, you define new methods for the
  ``+`` function. Existing code then seamlessly applies to the new data
  types.

부분적으로 런타임 타입 추론(타입 지시를 선택적으로 추가하여)을 이유로
그리고 프로젝트의 시발점에서 성능을 강조하였기에
줄리아의 계산 효율은 다른 동적 언어들에 비해 우월하며
심지어 정적으로 컴파일된 경쟁 언어들마저 능가한다.
대규모의 수치 해석 문제의 경우 속도는 매번 그래왔듯이
앞으로도 그렇고, 아마 항상 결정적 요소일 것이다:
처리되는 데이터의 양은 지난 수십년간 무어의 법칙을 따르고 있다
  Partly because of run-time type inference (augmented by optional type
  annotations), and partly because of a strong focus on performance from
  the inception of the project, Julia's computational efficiency exceeds
  that of other dynamic languages, and even rivals that of
  statically-compiled languages. For large scale numerical problems, speed
  always has been, continues to be, and probably always will be crucial:
  the amount of data being processed has easily kept pace with Moore's Law
  over the past decades.

줄리아는 단일 언어에 사용하기 쉽고 강력하고 뛰어난 효율도 갖는다는
전례없는 조합을 갖추는 것을 목표로 한다.
추가로 줄리아로 얻는 이득은 다음과 같이:
- 자유롭게 사용 가능하고 오픈 소스이다(MIT 라이센스)
- 사용자가 정의한 타입 또한 내장한 타입과 같이 빠르고 아담하다
- 성능을 위해 코드를 벡터화할 필요가 없다; 벡터화하지 않은 코드도 빠릅니다
- 병렬과 분산 처리를 위해 고안되었다
- 경량의 그린 쓰레딩(코루틴)
- 강요하지는 않지만 강력한 타입 시스템
- 수와 타입을 위한 우아하고 확장 가능한 컨버젼 및 프로모션(타입 변환)
- UTF-8을 비롯한 효율적인 유니코드 지원
- C 함수 직접 호출(별도의 래퍼나 특정한 API가 필요하지 않음)
- 다른 프로세스를 관리하는 쉘과 비슷한 강력한 기능
- 리스프와 비슷한 매크로, 메타프로그래밍을 위한 장치들
  Julia aims to create an unprecedented combination of ease-of-use, power,
  and efficiency in a single language. In addition to the above, some
  advantages of Julia over comparable systems include:
  -  Free and open source (`MIT
     licensed <https://github.com/JuliaLang/julia/blob/master/LICENSE.md>`_)
  -  User-defined types are as fast and compact as built-ins
  -  No need to vectorize code for performance; devectorized code is fast
  -  Designed for parallelism and distributed computation
  -  Lightweight "green" threading
     (`coroutines <http://en.wikipedia.org/wiki/Coroutine>`_)
  -  Unobtrusive yet powerful type system
  -  Elegant and extensible conversions and promotions for numeric and
     other types
  -  Efficient support for
     `Unicode <http://en.wikipedia.org/wiki/Unicode>`_, including but not
     limited to `UTF-8 <http://en.wikipedia.org/wiki/UTF-8>`_
  -  Call C functions directly (no wrappers or special APIs needed)
  -  Powerful shell-like capabilities for managing other processes
  -  Lisp-like macros and other metaprogramming facilities
