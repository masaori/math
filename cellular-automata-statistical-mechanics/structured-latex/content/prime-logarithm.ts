import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "prime_logarithm_definition_finite_integer_vectors",
    kind: "definition",
    title: { text: "素数上の有限台整数ベクトル" },
    labels: ["def_prime_integer_vectors"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`\mathcal P:=\{p\in\mathbb N:p\ge2\text{ かつ正の約数が }1,p\text{ だけ}\}`),
        " を素数の集合とする。写像 ", math(String.raw`a:\mathcal P\to\mathbb Z`),
        " の台を ", math(String.raw`\operatorname{supp}(a):=\{p\in\mathcal P:a(p)\ne0\}`), " と書き、"]),
      displayMath(String.raw`\Lambda:=\{a:\mathcal P\to\mathbb Z:\operatorname{supp}(a)\text{ は有限}\}`),
      paragraph(["と定める。元は非零の整数係数を持つ素数の有限表で表す。等号は全ての素数での係数の一致である。",
        "有限表を素数の昇順に並べれば自然数と整数の有限列になるので、", math(String.raw`\Lambda`),
        " は高々可算である。係数を実数で評価する操作は用いない。"]),
    ],
  },
  {
    id: "prime_logarithm_definition_additive_operations",
    kind: "definition",
    title: { text: "有限台整数ベクトルの加法構造" },
    labels: ["def_prime_vector_additive_operations"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_prime_integer_vectors"), " の ", math(String.raw`a,b\in\Lambda`),
        "、", math(String.raw`k\in\mathbb Z`), "、", math(String.raw`p\in\mathcal P`), " に対して"]),
      displayMath(String.raw`\begin{gathered}
(a+_\Lambda b)(p):=a(p)+b(p),\qquad 0_\Lambda(p):=0,\\
(-_\Lambda a)(p):=-a(p),\qquad (k\cdot_\Lambda a)(p):=k\,a(p).
\end{gathered}`),
      paragraph(["差は ", math(String.raw`a-_\Lambda b:=a+_\Lambda(-_\Lambda b)`),
        " と書く。和の台は二つの台の合併に含まれ、符号反転と整数倍の台は元の台に含まれるので、",
        "全ての結果は ", math(String.raw`\Lambda`), " に入る。これ以外の積や除算はここでは定義しない。"]),
    ],
  },
  {
    id: "prime_logarithm_claim_abelian_group",
    kind: "claim",
    title: { text: "有限台整数ベクトルは加法可換群をなす" },
    labels: ["claim_prime_vectors_abelian_group"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [paragraph([ref("def_prime_vector_additive_operations"), " の加法・零・符号反転は、",
      ref("def_prime_integer_vectors"), " の集合を可換群にする。すなわち加法は結合的かつ可換で、零は単位元、符号反転は加法逆元である。"])],
    proof: [
      paragraph([math(String.raw`a,b,c\in\Lambda`), "、", math(String.raw`p\in\mathcal P`), " を任意に取る。"]),
      displayMath(String.raw`\begin{aligned}
((a+_\Lambda b)+_\Lambda c)(p)
&=(a(p)+b(p))+c(p)\quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=a(p)+(b(p)+c(p))\quad(\because\ \mathbb Z\text{ の結合律})\\
&=(a+_\Lambda(b+_\Lambda c))(p)\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(a+_\Lambda b)(p)&=a(p)+b(p)\quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=b(p)+a(p)\quad(\because\ \mathbb Z\text{ の可換律})\\
&=(b+_\Lambda a)(p)\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(a+_\Lambda0_\Lambda)(p)&=a(p)+0\quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=a(p)\quad(\because\ \mathbb Z\text{ の零}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(a+_\Lambda(-_\Lambda a))(p)&=a(p)+(-a(p))\quad(\because\ \blkref{def_prime_vector_additive_operations})\\
&=0\quad(\because\ \mathbb Z\text{ の加法逆元})\\
&=0_\Lambda(p)\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      paragraph(["各等式は任意の素数で成り立つので、写像の外延性から群の各等式を得る。閉性は定義中で示した。"]),
    ],
  },
  {
    id: "prime_logarithm_definition_rational_valuation",
    kind: "definition",
    title: { text: "正の有理数の素数指数" },
    labels: ["def_positive_rational_prime_valuation"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "Q",
    statement: [
      paragraph([math(String.raw`q\in\mathbb Q_{>0}`), " を既約分数 ",
        math(String.raw`q=r/s`), "（", math(String.raw`r,s\in\mathbb N_{>0}`),
        "、", math(String.raw`\gcd(r,s)=1`), "）で一意に表す。各 ", math(String.raw`p\in\mathcal P`),
        "（", ref("def_prime_integer_vectors"), "）に対し、正整数の素因数分解における指数を ",
        math(String.raw`e_p(r),e_p(s)\in\mathbb Z_{\ge0}`), " と書き、"]),
      displayMath(String.raw`v_p(q):=e_p(r)-e_p(s)\in\mathbb Z`),
      paragraph(["と定める。ここで指数は、素因数分解の自然数の指数を標準単射 ",
        math(String.raw`j:\mathbb N\to\mathbb Z`), "（自然数回だけ整数の 1 を加える写像）で移した整数である。",
        "非負整数 ", math(String.raw`k`), " を指数に持つ ", math(String.raw`p^k`),
        " は、", math(String.raw`j(m)=k`), " を満たす唯一の自然数 ", math(String.raw`m`), " 回の積を意味する。",
        "素因数でない場合の指数は零。算術の基本定理により、非零となる素数は有限個である。",
        "正の有理数は既約分数の整数対で表し、その加減乗除と順序を使う。零はこの指数写像の入力ではない。"]),
    ],
  },
  {
    id: "prime_logarithm_definition_log",
    kind: "definition",
    title: { text: "素数指数による対数写像" },
    labels: ["def_prime_logarithm"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_positive_rational_prime_valuation"), " の指数を、",
        ref("def_prime_integer_vectors"), " の有限表へ渡す写像を"]),
      displayMath(String.raw`\log_\Lambda:\mathbb Q_{>0}\longrightarrow\Lambda,\qquad
(\log_\Lambda q)(p):=v_p(q)\quad(p\in\mathcal P)`),
      paragraph(["と定める。これは有限な素因数分解であり、級数や実対数では定義しない。"]),
    ],
  },
  {
    id: "prime_logarithm_definition_reconstruction",
    kind: "definition",
    title: { text: "有限台整数ベクトルから正の有理数への復元写像" },
    labels: ["def_prime_vector_reconstruction"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "Q",
    statement: [
      paragraph([math(String.raw`a\in\Lambda`), "（", ref("def_prime_integer_vectors"), "）に対し"]),
      displayMath(String.raw`R:\Lambda\longrightarrow\mathbb Q_{>0},\qquad
R(a):=
\frac{
  \prod_{p\in\operatorname{supp}(a)}p^{\max(a(p),0)}
}{
  \prod_{p\in\operatorname{supp}(a)}p^{\max(-a(p),0)}
}`),
      paragraph(["と定める。非負整数の指数の意味は ", ref("def_positive_rational_prime_valuation"),
        " による。積は有限で、空積は 1 とする。",
        "分子・分母は正整数なので除算は正の有理数の中で定義できる。",
        "これは実指数関数ではなく、素数の有限整数冪から分数を作る写像である。"]),
    ],
  },
  {
    id: "prime_logarithm_claim_inverse",
    kind: "claim",
    title: { text: "対数写像と復元写像は互いに逆である" },
    labels: ["claim_prime_logarithm_inverse"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`q\in\mathbb Q_{>0}`), "、", math(String.raw`a\in\Lambda`), " に対し"]),
      displayMath(String.raw`R(\log_\Lambda q)=q,\qquad \log_\Lambda(R(a))=a`),
      paragraph(["が成り立つ（", ref("def_prime_logarithm"), "、", ref("def_prime_vector_reconstruction"), "）。"]),
    ],
    proof: [
      paragraph([math(String.raw`q=r/s`), " を ", ref("def_positive_rational_prime_valuation"),
        " の既約表示とする。", math(String.raw`K:=\{p:e_p(r)>0\text{ または }e_p(s)>0\}`),
        " は有限である。互いに素なので各素数について二つの指数の少なくとも一方は零である。",
        ref("def_prime_logarithm"), " と ", ref("def_positive_rational_prime_valuation"),
        " により ", math(String.raw`K=\operatorname{supp}(\log_\Lambda q)`), " である。"]),
      displayMath(String.raw`\begin{aligned}
R(\log_\Lambda q)
&=\frac{\prod_{p\in K}p^{\max((\log_\Lambda q)(p),0)}}{\prod_{p\in K}p^{\max(-(\log_\Lambda q)(p),0)}}
  \quad(\because\ \blkref{def_prime_vector_reconstruction})\\
&=\frac{\prod_{p\in K}p^{\max(v_p(q),0)}}{\prod_{p\in K}p^{\max(-v_p(q),0)}}
  \quad(\because\ \blkref{def_prime_logarithm})\\
&=\frac{\prod_{p\in K}p^{\max(e_p(r)-e_p(s),0)}}{\prod_{p\in K}p^{\max(e_p(s)-e_p(r),0)}}
  \quad(\because\ \blkref{def_positive_rational_prime_valuation})\\
&=\frac{\prod_{p\in K}p^{e_p(r)}}{\prod_{p\in K}p^{e_p(s)}}
  \quad(\because\ \gcd(r,s)=1)\\
&=r/s\quad(\because\ \text{算術の基本定理})\\
&=q\quad(\because\ q\text{ の既約表示}).
\end{aligned}`),
      paragraph(["逆方向では ", math(String.raw`a\in\Lambda`), " を固定する。",
        ref("def_prime_vector_reconstruction"), " の分子と分母は互いに素であり、各 ",
        math(String.raw`p\in\mathcal P`), " について"]),
      displayMath(String.raw`\begin{aligned}
(\log_\Lambda(R(a)))(p)&=v_p(R(a))\quad(\because\ \blkref{def_prime_logarithm})\\
&=\max(a(p),0)-\max(-a(p),0)
  \quad(\because\ \text{算術の基本定理と }\blkref{def_prime_vector_reconstruction})\\
&=a(p)\quad(\because\ a(p)\ge0\text{ と }a(p)<0\text{ の場合分け}).
\end{aligned}`),
      paragraph(["台の外では両指数が零なので同じ計算が成り立つ。写像の外延性で結論する。"]),
    ],
  },
  {
    id: "prime_logarithm_claim_product",
    kind: "claim",
    title: { text: "正の有理数の積の対数は対数の和である" },
    labels: ["claim_prime_logarithm_product"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`q,t\in\mathbb Q_{>0}`), " に対し、", ref("def_prime_logarithm"),
        " と ", ref("def_prime_vector_additive_operations"), " は"]),
      displayMath(String.raw`\log_\Lambda(qt)=\log_\Lambda q+_\Lambda\log_\Lambda t`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph(["既約分数 ", math(String.raw`q=r/s`), "、", math(String.raw`t=u/v`),
        "（", math(String.raw`r,s,u,v\in\mathbb N_{>0}`), "）を取り、",
        math(String.raw`g:=\gcd(ru,sv)`), " とする。", math(String.raw`ru/g,sv/g`),
        " は正整数であり、", math(String.raw`qt=(ru/g)/(sv/g)`), " は既約である。各 ",
        math(String.raw`p\in\mathcal P`), " について、"]),
      displayMath(String.raw`\begin{aligned}
(\log_\Lambda(qt))(p)&=v_p(qt)\quad(\because\ \blkref{def_prime_logarithm})\\
&=e_p(ru/g)-e_p(sv/g)\quad(\because\ \blkref{def_positive_rational_prime_valuation})\\
&=(e_p(ru)-e_p(g))-(e_p(sv)-e_p(g))\quad(\because\ \text{整除と素因数分解})\\
&=(e_p(r)+e_p(u)-e_p(g))-(e_p(s)+e_p(v)-e_p(g))
  \quad(\because\ \text{積の素因数分解})\\
&=(e_p(r)-e_p(s))+(e_p(u)-e_p(v))\quad(\because\ \mathbb Z\text{ の算術})\\
&=v_p(q)+v_p(t)\quad(\because\ \blkref{def_positive_rational_prime_valuation})\\
&=(\log_\Lambda q)(p)+(\log_\Lambda t)(p)\quad(\because\ \blkref{def_prime_logarithm})\\
&=(\log_\Lambda q+_\Lambda\log_\Lambda t)(p)\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      paragraph(["写像の外延性で結論する。"]),
    ],
  },
  {
    id: "prime_logarithm_claim_ratio",
    kind: "claim",
    title: { text: "正の有理数の比の対数は対数の差である" },
    labels: ["claim_prime_logarithm_ratio"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`q,t\in\mathbb Q_{>0}`), " に対して"]),
      displayMath(String.raw`\log_\Lambda(q/t)=\log_\Lambda q-_\Lambda\log_\Lambda t`),
      paragraph(["が成り立つ（", ref("def_prime_logarithm"), "、", ref("def_prime_vector_additive_operations"), "）。"]),
    ],
    proof: [
      paragraph([math(String.raw`t=u/v`), "（", math(String.raw`u,v\in\mathbb N_{>0}`),
        "）を既約表示とする。", math(String.raw`t^{-1}=v/u`), " も既約である。任意の ", math(String.raw`p\in\mathcal P`), " について"]),
      displayMath(String.raw`\begin{aligned}
(\log_\Lambda(t^{-1}))(p)&=v_p(t^{-1})\quad(\because\ \blkref{def_prime_logarithm})\\
&=e_p(v)-e_p(u)\quad(\because\ \blkref{def_positive_rational_prime_valuation})\\
&=-(e_p(u)-e_p(v))\quad(\because\ \mathbb Z\text{ の減法})\\
&=-v_p(t)\quad(\because\ \blkref{def_positive_rational_prime_valuation})\\
&=-(\log_\Lambda t)(p)\quad(\because\ \blkref{def_prime_logarithm})\\
&=(-_\Lambda\log_\Lambda t)(p)\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      paragraph(["写像の外延性で逆数の対数が符号反転になることを得る。"]),
      displayMath(String.raw`\begin{aligned}
\log_\Lambda(q/t)&=\log_\Lambda(qt^{-1})\quad(\because\ \mathbb Q_{>0}\text{ の除算})\\
&=\log_\Lambda q+_\Lambda\log_\Lambda(t^{-1})\quad(\because\ \blkref{claim_prime_logarithm_product})\\
&=\log_\Lambda q+_\Lambda(-_\Lambda\log_\Lambda t)\quad(\because\ \text{上の逆数の計算})\\
&=\log_\Lambda q-_\Lambda\log_\Lambda t\quad(\because\ \blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
    ],
  },
  {
    id: "prime_logarithm_definition_order",
    kind: "definition",
    title: { text: "正の有理数の比較で定める有限台整数ベクトルの順序" },
    labels: ["def_prime_vector_order"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`a,b\in\Lambda`), " に対し、", ref("def_prime_vector_reconstruction"), " を使い"]),
      displayMath(String.raw`a\le_\Lambda b\quad:\!\iff\quad R(a)\le R(b)`),
      paragraph(["と定める。右辺の順序は正の有理数の順序である。復元した分数を ",
        math(String.raw`R(a)=r/s`), "、", math(String.raw`R(b)=u/v`), " と書けば、",
        math(String.raw`r,s,u,v\in\mathbb N_{>0}`), " で ", math(String.raw`rv\le us`),
        " という整数比較で判定できる。係数ごとの順序ではない。"]),
    ],
  },
  {
    id: "prime_logarithm_claim_ordered_group",
    kind: "claim",
    title: { text: "対数写像は正の有理数の順序を保ち加法は順序と両立する" },
    labels: ["claim_prime_logarithm_ordered_group"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_prime_vector_order"), " の順序は ", ref("claim_prime_vectors_abelian_group"),
        " の加法と両立する全順序である。", math(String.raw`q,t\in\mathbb Q_{>0}`), " に対し"]),
      displayMath(String.raw`\log_\Lambda q\le_\Lambda\log_\Lambda t\iff q\le t`),
      paragraph(["となる。以下、この順序付き加法群を対数順序群と呼ぶ。"]),
    ],
    proof: [
      paragraph([ref("claim_prime_logarithm_inverse"), " により ", math(String.raw`R`),
        " は単射である。反射律・推移律・全比較可能性は正の有理数の順序から移り、反対称律は単射性から移る。",
        math(String.raw`a,b,c\in\Lambda`), " とする。まず ", math(String.raw`a,c`), " について"]),
      displayMath(String.raw`\begin{aligned}
R(a+_\Lambda c)&=R(\log_\Lambda R(a)+_\Lambda\log_\Lambda R(c))
  \quad(\because\ \blkref{claim_prime_logarithm_inverse})\\
&=R(\log_\Lambda(R(a)R(c)))\quad(\because\ \blkref{claim_prime_logarithm_product})\\
&=R(a)R(c)\quad(\because\ \blkref{claim_prime_logarithm_inverse}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a+_\Lambda c\le_\Lambda b+_\Lambda c
&\iff R(a+_\Lambda c)\le R(b+_\Lambda c)\quad(\because\ \blkref{def_prime_vector_order})\\
&\iff R(a)R(c)\le R(b)R(c)\quad(\because\ \text{上の復元の積公式})\\
&\iff R(a)\le R(b)\quad(\because\ R(c)>0)\\
&\iff a\le_\Lambda b\quad(\because\ \blkref{def_prime_vector_order}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log_\Lambda q\le_\Lambda\log_\Lambda t
&\iff R(\log_\Lambda q)\le R(\log_\Lambda t)\quad(\because\ \blkref{def_prime_vector_order})\\
&\iff q\le t\quad(\because\ \blkref{claim_prime_logarithm_inverse}).
\end{aligned}`),
    ],
  },
  {
    id: "prime_logarithm_claim_integer_division",
    kind: "claim",
    title: { text: "対数順序群内の整数除算は全係数の整除に限る" },
    labels: ["claim_prime_vector_integer_division"],
    verification: ["sagemath/check/logarithmic-counts"],
    habitat: "countable",
    statement: [
      paragraph([math(String.raw`a\in\Lambda`), "、", math(String.raw`d\in\mathbb Z\setminus\{0\}`),
        " に対し、", ref("def_prime_vector_additive_operations"), " の整数倍について"]),
      displayMath(String.raw`(\exists! b\in\Lambda:\ d\cdot_\Lambda b=a)
\iff (\forall p\in\operatorname{supp}(a):d\mid a(p))`),
      paragraph(["が成り立つ。", math(String.raw`d\mid z`), " は ", math(String.raw`z\in\mathbb Z`),
        " に対して ", math(String.raw`z=dk`), " を満たす ", math(String.raw`k\in\mathbb Z`),
        " が存在することをいう。除算はこの条件を満たす入力に限って定義できる。"]),
    ],
    proof: [
      paragraph(["順方向は ", math(String.raw`d\cdot_\Lambda b=a`), " の各係数から ",
        math(String.raw`a(p)=d\,b(p)`), "（", ref("def_prime_vector_additive_operations"),
        "）を得るので、整除の証人は ", math(String.raw`b(p)\in\mathbb Z`), " である。"]),
      paragraph(["逆方向では有限な台の各素数で ", math(String.raw`d\,b(p)=a(p)`),
        " を満たす整数を取り、台の外で ", math(String.raw`b(p):=0`), " と定める。",
        math(String.raw`\operatorname{supp}(b)\subseteq\operatorname{supp}(a)`),
        " なので ", math(String.raw`b\in\Lambda`), "（", ref("def_prime_integer_vectors"),
        "）。各係数の等式と ", ref("def_prime_vector_additive_operations"), " から存在が従う。"]),
      paragraph(["二つの解 ", math(String.raw`b,c\in\Lambda`), " があれば、全ての ", math(String.raw`p\in\mathcal P`), " について"]),
      displayMath(String.raw`\begin{aligned}
d\,b(p)&=a(p)\quad(\because\ \text{解の条件と }\blkref{def_prime_vector_additive_operations})\\
&=d\,c(p)\quad(\because\ \text{解の条件と }\blkref{def_prime_vector_additive_operations}).
\end{aligned}`),
      paragraph([math(String.raw`d\ne0`), " による整数の乗法の消去律で ", math(String.raw`b(p)=c(p)`),
        "。写像の外延性で一意性を得る。"]),
    ],
  },
]);
