import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_mathematical_tools",
    kind: "heading",
    level: 1,
    title: { text: "数学的道具立て" },
    labels: [],
  },
  {
    id: "heading_calculation_formulae",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 1 },
    title: { text: "計算公式" },
    labels: [],
  },
  {
    id: "calculation_formulae_definition_set_and_algebra_notation",
    kind: "definition",
    origin: { path: "exact-solution-of-2d-ising-model/main.md", ordinal: 1 },
    title: { text: "集合と代数構造の記号" },
    labels: ["set_and_algebra_notation"],
    statement: [
      paragraph([
        "自然数・整数・実数の集合そのものはこの論文では構成せず、既知の集合としてそれぞれ ",
        math(String.raw`\mathbf{N},\ \mathbf{Z},\ \mathbf{R}`),
        " と書く。演算を持たない集合の記号と、演算を持つ代数構造の記号を区別する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathbb{N}&:=\left(\mathbf{N},+_{\mathbb{N}},\cdot_{\mathbb{N}},0_{\mathbb{N}},1_{\mathbb{N}},\le_{\mathbb{N}}\right),\\
\mathbb{Z}&:=\left(\mathbf{Z},+_{\mathbb{Z}},\cdot_{\mathbb{Z}},0_{\mathbb{Z}},1_{\mathbb{Z}},-_{\mathbb{Z}},\le_{\mathbb{Z}}\right),\\
\mathbb{R}&:=\left(\mathbf{R},+_{\mathbb{R}},\cdot_{\mathbb{R}},0_{\mathbb{R}},1_{\mathbb{R}},-_{\mathbb{R}},(\cdot)^{-1}_{\mathbb{R}},\le_{\mathbb{R}}\right).
\end{aligned}`),
      paragraph(["各演算と順序の所属は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
+_{\mathbb{N}},\cdot_{\mathbb{N}}&:\mathbf{N}\times\mathbf{N}\to\mathbf{N},\\
+_{\mathbb{Z}},\cdot_{\mathbb{Z}}&:\mathbf{Z}\times\mathbf{Z}\to\mathbf{Z},\\
+_{\mathbb{R}},\cdot_{\mathbb{R}}&:\mathbf{R}\times\mathbf{R}\to\mathbf{R},\\
-_{\mathbb{Z}}&:\mathbf{Z}\to\mathbf{Z},\\
-_{\mathbb{R}}&:\mathbf{R}\to\mathbf{R},\qquad
(\cdot)^{-1}_{\mathbb{R}}:\mathbf{R}\setminus\{0_{\mathbb{R}}\}\to\mathbf{R},\\
\le_{\mathbb{N}}&\subset\mathbf{N}\times\mathbf{N},\qquad
\le_{\mathbb{Z}}\subset\mathbf{Z}\times\mathbf{Z},\qquad
\le_{\mathbb{R}}\subset\mathbf{R}\times\mathbf{R}.
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbb{N}`),
        " は自然数の半環、",
        math(String.raw`\mathbb{Z}`),
        " は整数環、",
        math(String.raw`\mathbb{R}`),
        " は完備順序体（下の体の公理と順序の条件を満たす順序体）を表す。たとえば ",
        math(String.raw`n\in\mathbb{Z}`),
        " は厳密には ",
        math(String.raw`n\in\mathbf{Z}`),
        " の略記であり、計算式中の ",
        math(String.raw`a+b`),
        " は所属が ",
        math(String.raw`a,b\in\mathbf{Z}`),
        " なら ",
        math(String.raw`a+_{\mathbb{Z}}b`),
        "、所属が ",
        math(String.raw`a,b\in\mathbf{R}`),
        " なら ",
        math(String.raw`a+_{\mathbb{R}}b`),
        " の略記とする。積、零元、単位元についても同様に、所属する代数構造の添字を省略した略記である。",
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " の演算が満たす性質のうち、体であること（体の公理）は次の等式と条件からなる。任意の ",
        math(String.raw`x,y,t\in\mathbf{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&(x+y)+t=x+(y+t)
&&\text{（加法の結合律）},\\
&x+y=y+x
&&\text{（加法の交換律。加法の可換律・和の可換律とも書く）},\\
&x+0_{\mathbb{R}}=x,\qquad 0_{\mathbb{R}}+x=x
&&\text{（}0_{\mathbb{R}}\ \text{は加法の単位元）},\\
&x+(-x)=0_{\mathbb{R}},\qquad (-x)+x=0_{\mathbb{R}}
&&\text{（加法の逆元）},\\
&(x\cdot y)\cdot t=x\cdot(y\cdot t)
&&\text{（乗法の結合律。積の結合律とも書く）},\\
&x\cdot y=y\cdot x
&&\text{（乗法の可換律。乗法の交換律・積の可換律とも書く）},\\
&x\cdot 1_{\mathbb{R}}=x,\qquad 1_{\mathbb{R}}\cdot x=x
&&\text{（}1_{\mathbb{R}}\ \text{は乗法の単位元）},\\
&x\neq 0_{\mathbb{R}}\ \Rightarrow\ \bigl(x\cdot x^{-1}=1_{\mathbb{R}}\ \text{かつ}\ x^{-1}\cdot x=1_{\mathbb{R}}\bigr)
&&\text{（乗法の逆元）},\\
&x\cdot(y+t)=x\cdot y+x\cdot t,\qquad (x+y)\cdot t=x\cdot t+y\cdot t
&&\text{（分配律）},\\
&0_{\mathbb{R}}\neq 1_{\mathbb{R}}
&&\text{（零元と単位元の相違）}.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`-x`),
        " は ",
        math(String.raw`-_{\mathbb{R}}(x)`),
        "、",
        math(String.raw`x^{-1}`),
        " は ",
        math(String.raw`(x)^{-1}_{\mathbb{R}}`),
        " の略記である（",
        math(String.raw`-_{\mathbb{R}}`),
        " は符号反転、",
        math(String.raw`(\cdot)^{-1}_{\mathbb{R}}`),
        " は逆数）。本文の証明で「",
        math(String.raw`\mathbb{R}`),
        " の加法の交換律」などと引くのは、この一覧の該当する行である。",
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " の順序 ",
        math(String.raw`\le_{\mathbb{R}}`),
        " が満たす性質として、証明が使うのは次の条件だけである。任意の ",
        math(String.raw`x,y,t\in\mathbf{R}`),
        " と部分集合 ",
        math(String.raw`S\subset\mathbf{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&x\le x
&&\text{（順序の反射律）},\\
&(x\le y\ \wedge\ y\le x)\ \Rightarrow\ x=y
&&\text{（順序の反対称律）},\\
&(x\le y\ \wedge\ y\le t)\ \Rightarrow\ x\le t
&&\text{（順序の推移律）},\\
&x\le y\ \vee\ y\le x
&&\text{（全順序）},\\
&x\le y\ \Rightarrow\ x+t\le y+t
&&\text{（順序と加法の両立）},\\
&(0_{\mathbb{R}}\le x\ \wedge\ 0_{\mathbb{R}}\le y)\ \Rightarrow\ 0_{\mathbb{R}}\le x\cdot y
&&\text{（順序と乗法の両立）},\\
&\bigl(S\neq\emptyset\ \wedge\ \exists v\in\mathbf{R},\ \forall s\in S,\ s\le v\bigr)\\
&\quad\Rightarrow\ \exists b\in\mathbf{R},\ \bigl(\forall s\in S,\ s\le b\bigr)\ \wedge\ \bigl(\forall u\in\mathbf{R},\ (\forall s\in S,\ s\le u)\Rightarrow b\le u\bigr)
&&\text{（上限の存在）}.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`x\le y`),
        " は ",
        math(String.raw`(x,y)\in\le_{\mathbb{R}}`),
        " の略記であり、",
        math(String.raw`x\ge y`),
        " は ",
        math(String.raw`y\le x`),
        " の略記とする。最後の行は、空でなく上に有界な部分集合が最小の上界を持つことを述べる。この行を使う証明は、使う箇所で非可算集合 ",
        math(String.raw`\mathbf{R}`),
        " の完備性へ移行することを明示する。狭義の順序 ",
        math(String.raw`<`),
        "・",
        math(String.raw`>`),
        " は ",
        ref("def_real_strict_order"),
        " で定める。本文の証明で「",
        math(String.raw`\mathbb{R}`),
        " の順序の推移律」などと引くのは、この一覧の該当する行である。",
      ]),
      paragraph([
        math(String.raw`\mathbb{N}`),
        " の演算と順序は外から持ち込み、使う性質は次の条件だけとする。任意の ",
        math(String.raw`x,y,t\in\mathbf{N}`),
        " と、",
        math(String.raw`\mathbf{N}`),
        " の元についての命題 ",
        math(String.raw`\varphi(n)`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&x+0_{\mathbb{N}}=x,\qquad x+(y+1_{\mathbb{N}})=(x+y)+1_{\mathbb{N}}
&&\text{（和の再帰の式）},\\
&x\cdot 0_{\mathbb{N}}=0_{\mathbb{N}},\qquad x\cdot(y+1_{\mathbb{N}})=x\cdot y+x
&&\text{（積の再帰の式）},\\
&x+1_{\mathbb{N}}\neq 0_{\mathbb{N}},\qquad x+1_{\mathbb{N}}=y+1_{\mathbb{N}}\ \Rightarrow\ x=y
&&\text{（後者の性質）},\\
&\Bigl(\varphi(0_{\mathbb{N}})\ \wedge\ \bigl(\forall n\in\mathbf{N},\ \varphi(n)\Rightarrow\varphi(n+1_{\mathbb{N}})\bigr)\Bigr)\ \Rightarrow\ \forall n\in\mathbf{N},\ \varphi(n)
&&\text{（数学的帰納法）},\\
&(x+y)+t=x+(y+t),\qquad x+y=y+x,\qquad 0_{\mathbb{N}}+x=x
&&\text{（加法の結合律・交換律・単位元）},\\
&(x\cdot y)\cdot t=x\cdot(y\cdot t),\qquad x\cdot y=y\cdot x,\qquad x\cdot 1_{\mathbb{N}}=x,\qquad 1_{\mathbb{N}}\cdot x=x
&&\text{（乗法の結合律・交換律・単位元）},\\
&x\cdot(y+t)=x\cdot y+x\cdot t,\qquad (x+y)\cdot t=x\cdot t+y\cdot t
&&\text{（分配律）},\\
&x+t=y+t\ \Rightarrow\ x=y
&&\text{（加法の簡約律）},\\
&x\le y\ \Leftrightarrow\ \exists d\in\mathbf{N},\ x+d=y
&&\text{（順序と和）},\\
&x\le x,\qquad (x\le y\ \wedge\ y\le x)\ \Rightarrow\ x=y,\qquad (x\le y\ \wedge\ y\le t)\ \Rightarrow\ x\le t
&&\text{（順序の反射律・反対称律・推移律）},\\
&x\le y\ \vee\ y\le x
&&\text{（全順序）},\\
&x\le y\ \Rightarrow\ x+t\le y+t
&&\text{（順序と加法の両立）}.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`x\le y`),
        " は ",
        math(String.raw`(x,y)\in\le_{\mathbb{N}}`),
        " の略記である。",
        math(String.raw`\mathbb{N}`),
        " の狭義の順序と、逆向きの記号を",
      ]),
      displayMath(String.raw`x<y\ :\Leftrightarrow\ x+1_{\mathbb{N}}\le y,\qquad x>y\ :\Leftrightarrow\ y<x,\qquad x\ge y\ :\Leftrightarrow\ y\le x`),
      paragraph([
        "で定める。",
        math(String.raw`x\le y`),
        " のとき、",
        math(String.raw`x+d=y`),
        " を満たす ",
        math(String.raw`d\in\mathbf{N}`),
        " は順序と和の行により存在し、加法の簡約律と加法の交換律によりただ一つである。これを ",
        math(String.raw`\mathbb{N}`),
        " の差 ",
        math(String.raw`y-x`),
        " と書く（",
        math(String.raw`x\le y`),
        " でない組には差を定めない）。",
        math(String.raw`\mathbb{N}`),
        " の元を十進の数字で書くとき、",
        math(String.raw`0`),
        " と ",
        math(String.raw`1`),
        " は ",
        math(String.raw`0_{\mathbb{N}}`),
        " と ",
        math(String.raw`1_{\mathbb{N}}`),
        " であり、元 ",
        math(String.raw`n`),
        " を表す数字の次の数字が表す元は ",
        math(String.raw`n+1_{\mathbb{N}}`),
        " である（次の行の和は ",
        math(String.raw`+_{\mathbb{N}}`),
        "）。",
      ]),
      displayMath(String.raw`2:=1+1,\qquad 3:=2+1,\qquad 4:=3+1,\qquad \dots`),
      paragraph([
        "本文の証明が ",
        math(String.raw`\mathbb{N}`),
        " の性質を根拠に引くときは、この一覧の該当する行を「",
        math(String.raw`\mathbb{N}`),
        " の加法の結合律」「数学的帰納法」などの名前で引く。",
      ]),
      paragraph([
        math(String.raw`\mathbb{N}`),
        " の上の写像を帰納法で定めるときは、次の再帰による定義を外から持ち込む。任意の集合 ",
        math(String.raw`X`),
        "、元 ",
        math(String.raw`a\in X`),
        "、写像 ",
        math(String.raw`f:\mathbf{N}\times X\to X`),
        " について",
      ]),
      displayMath(String.raw`h(0_{\mathbb{N}})=a,\qquad h(n+1_{\mathbb{N}})=f\bigl(n,h(n)\bigr)\quad(n\in\mathbf{N})
\qquad\text{（再帰による定義）}`),
      paragraph([
        "を満たす写像 ",
        math(String.raw`h:\mathbf{N}\to X`),
        " がただ一つある。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}`),
        " の演算と順序も外から持ち込み、使う性質は次の条件だけとする。",
        math(String.raw`-x`),
        " は ",
        math(String.raw`-_{\mathbb{Z}}(x)`),
        " の略記であり（",
        math(String.raw`-_{\mathbb{Z}}`),
        " は符号反転）、",
        math(String.raw`x\le y`),
        " は ",
        math(String.raw`(x,y)\in\le_{\mathbb{Z}}`),
        " の略記、",
        math(String.raw`x\ge y`),
        " は ",
        math(String.raw`y\le x`),
        " の略記である。任意の ",
        math(String.raw`x,y,t,k\in\mathbf{Z}`),
        " と、",
        math(String.raw`\mathbf{Z}`),
        " の元についての命題 ",
        math(String.raw`\varphi(n)`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&(x+y)+t=x+(y+t)
&&\text{（加法の結合律。和の結合律とも書く）},\\
&x+y=y+x
&&\text{（加法の交換律。加法の可換律とも書く）},\\
&x+0_{\mathbb{Z}}=x,\qquad 0_{\mathbb{Z}}+x=x
&&\text{（}0_{\mathbb{Z}}\ \text{は加法の単位元。和の単位元とも書く）},\\
&x+(-x)=0_{\mathbb{Z}},\qquad (-x)+x=0_{\mathbb{Z}}
&&\text{（加法の逆元。加法逆元とも書く）},\\
&(x\cdot y)\cdot t=x\cdot(y\cdot t),\qquad x\cdot y=y\cdot x
&&\text{（乗法の結合律・交換律）},\\
&x\cdot 1_{\mathbb{Z}}=x,\qquad 1_{\mathbb{Z}}\cdot x=x
&&\text{（}1_{\mathbb{Z}}\ \text{は乗法の単位元。積の単位元とも書く）},\\
&x\cdot(y+t)=x\cdot y+x\cdot t,\qquad (x+y)\cdot t=x\cdot t+y\cdot t
&&\text{（分配律）},\\
&0_{\mathbb{Z}}\neq 1_{\mathbb{Z}}
&&\text{（零元と単位元の相違）},\\
&x\le x,\qquad (x\le y\ \wedge\ y\le x)\ \Rightarrow\ x=y,\qquad (x\le y\ \wedge\ y\le t)\ \Rightarrow\ x\le t
&&\text{（順序の反射律・反対称律・推移律）},\\
&x\le y\ \vee\ y\le x
&&\text{（全順序）},\\
&x\le y\ \Rightarrow\ x+t\le y+t
&&\text{（順序と加法の両立）},\\
&(0_{\mathbb{Z}}\le x\ \wedge\ 0_{\mathbb{Z}}\le y)\ \Rightarrow\ 0_{\mathbb{Z}}\le x\cdot y
&&\text{（順序と乗法の両立）},\\
&0_{\mathbb{Z}}\le x\ \Rightarrow\ \bigl(x=0_{\mathbb{Z}}\ \vee\ \exists n\in\mathbf{Z},\ (0_{\mathbb{Z}}\le n\ \wedge\ x=n+1_{\mathbb{Z}})\bigr)
&&\text{（}0_{\mathbb{Z}}\ \text{以上の元は}\ 0_{\mathbb{Z}}\ \text{か、}0_{\mathbb{Z}}\ \text{以上の元に}\ 1_{\mathbb{Z}}\ \text{を足したもの）},\\
&\Bigl(\varphi(k)\ \wedge\ \bigl(\forall n\in\mathbf{Z},\ (k\le n\ \wedge\ \varphi(n))\Rightarrow\varphi(n+1_{\mathbb{Z}})\bigr)\Bigr)\ \Rightarrow\ \forall n\in\mathbf{Z},\ \bigl(k\le n\Rightarrow\varphi(n)\bigr)
&&\text{（}k\ \text{から始める数学的帰納法）}.
\end{aligned}`),
      paragraph([
        "最後から二つ目の行は最後の行（",
        math(String.raw`k=0_{\mathbb{Z}}`),
        "）から導けるが、",
        ref("inclusion_zz_to_rr"),
        " が ",
        math(String.raw`\mathbb{Z}_{\ge 0}`),
        " の上の帰納的な定義に引くので並べておく。",
        math(String.raw`\mathbb{Z}`),
        " の元を数字で書くとき、",
        math(String.raw`0`),
        " と ",
        math(String.raw`1`),
        " は ",
        math(String.raw`0_{\mathbb{Z}}`),
        " と ",
        math(String.raw`1_{\mathbb{Z}}`),
        " である。",
      ]),
      paragraph([
        "本文の証明が ",
        math(String.raw`\mathbb{Z}`),
        " の性質を根拠に引くときは、この一覧の該当する行を「",
        math(String.raw`\mathbb{Z}`),
        " の加法の結合律」「",
        math(String.raw`\mathbb{Z}`),
        " の分配律」などの名前で引く。",
      ]),
      paragraph([
        "命題をつなぐ論理の記号（否定 ",
        math(String.raw`\neg`),
        "、かつ ",
        math(String.raw`\wedge`),
        "、または ",
        math(String.raw`\vee`),
        "、ならば ",
        math(String.raw`\Rightarrow`),
        "、同値 ",
        math(String.raw`\Leftrightarrow`),
        "、偽の命題 ",
        math(String.raw`\bot`),
        "）、量化子（任意の ",
        math(String.raw`\forall`),
        "、存在する ",
        math(String.raw`\exists`),
        "）と、一つの集合の二つの元の等号 ",
        math(String.raw`=`),
        " は、この論文では定義せず外から持ち込む。証明が使う性質は次の規則だけである。任意の集合 ",
        math(String.raw`X,\ Y`),
        "、元 ",
        math(String.raw`a,b,c\in X`),
        "、",
        math(String.raw`a',b'\in Y`),
        "、写像 ",
        math(String.raw`f,g:X\to Y`),
        "、命題 ",
        math(String.raw`P,\ Q,\ R`),
        "、",
        math(String.raw`X`),
        " の元についての命題 ",
        math(String.raw`\varphi(x)`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&a=a
&&\text{（等号の反射律）},\\
&a=b\ \Rightarrow\ b=a
&&\text{（等号の対称律）},\\
&(a=b\ \wedge\ b=c)\ \Rightarrow\ a=c
&&\text{（等号の推移律）},\\
&a=b\ \Rightarrow\ f(a)=f(b),\qquad (a=b\ \wedge\ \varphi(a))\ \Rightarrow\ \varphi(b)
&&\text{（等しいものの代入）},\\
&(a,a')=(b,b')\ \Leftrightarrow\ (a=b\ \wedge\ a'=b')
&&\text{（直積の元の等号は成分ごとの等号）},\\
&f=g\ \Leftrightarrow\ (\forall x\in X,\ f(x)=g(x))
&&\text{（写像の等号は全ての点での値の等号）},\\
&(P\wedge Q)\ \Rightarrow\ P,\qquad (P\wedge Q)\ \Rightarrow\ Q,\qquad P\ \text{と}\ Q\ \text{から}\ P\wedge Q
&&\text{（かつの除去と導入）},\\
&P\ \Rightarrow\ (P\vee Q),\qquad Q\ \Rightarrow\ (P\vee Q),\qquad
\bigl((P\vee Q)\wedge(P\Rightarrow R)\wedge(Q\Rightarrow R)\bigr)\ \Rightarrow\ R
&&\text{（またはの導入と場合分け）},\\
&\bigl(P\wedge(P\Rightarrow Q)\bigr)\ \Rightarrow\ Q,\qquad P\ \text{を仮定して}\ Q\ \text{を導けば}\ P\Rightarrow Q
&&\text{（ならばの除去と導入）},\\
&(P\Leftrightarrow Q)\ :\Leftrightarrow\ \bigl((P\Rightarrow Q)\wedge(Q\Rightarrow P)\bigr)
&&\text{（同値）},\\
&\bot\ \Rightarrow\ P
&&\text{（偽からは任意の命題が従う）},\\
&\neg P\ :\Leftrightarrow\ (P\Rightarrow\bot)
&&\text{（否定）},\\
&P\vee\neg P
&&\text{（排中律）},\\
&a\neq b\ :\Leftrightarrow\ \neg(a=b)
&&\text{（等号の否定）},\\
&(\forall x\in X,\ \varphi(x))\ \Rightarrow\ \varphi(a),\qquad
\text{仮定に現れない}\ x\in X\ \text{について}\ \varphi(x)\ \text{を導けば}\ \forall x\in X,\ \varphi(x)
&&\text{（任意の除去と導入）},\\
&\varphi(a)\ \Rightarrow\ (\exists x\in X,\ \varphi(x)),\qquad
\bigl((\exists x\in X,\ \varphi(x))\wedge(\forall x\in X,\ (\varphi(x)\Rightarrow Q))\bigr)\ \Rightarrow\ Q\ \ (Q\ \text{は}\ x\ \text{を含まない})
&&\text{（存在の導入と除去）}.
\end{aligned}`),
      paragraph([
        "否定の定義とならばの除去から、",
        math(String.raw`P`),
        " と ",
        math(String.raw`\neg P`),
        " からは ",
        math(String.raw`\bot`),
        " が従う。背理法と、対偶からもとの命題を得る推論は、排中律と場合分けから従う。等号は同じ集合の二つの元のあいだにだけ書く。本文の証明で「等号の対称律」などと引くのは、この一覧の該当する行である。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}_{\ge k}`),
        "、",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " などは代数構造そのものではなく、その台集合から順序条件で切り出した部分集合の略記とする。たとえば",
      ]),
      displayMath(String.raw`\mathbb{Z}_{\ge k}:=\{n\in\mathbf{Z}\mid k\le_{\mathbb{Z}}n\},\qquad
\mathbb{R}_{\ge 0}:=\{x\in\mathbf{R}\mid 0_{\mathbb{R}}\le_{\mathbb{R}}x\}.`),
      paragraph([
        "複素数の台集合と演算を持つ構造 ",
        math(String.raw`\mathbb{C}`),
        " はここでは定義せず、後の ",
        ref("definition_of_cc"),
        " で ",
        math(String.raw`\mathbf{R}^{2}`),
        " に加法と乗法を入れて定義する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "main.md 冒頭の記号方針を、集合と代数構造を混同しない本文定義として追加した。複素数は既存定義と重複させていない。",
        "2026-11-19（Lean の通しの証明のゴールラインの確認）: ℝ を「順序体」とだけ書いて体の等式を並べていなかったので、本文の証明が「ℝ の加法の交換律 p + q = q + p（set_and_algebra_notation）」のように引く等式（加法・乗法の結合律と交換律、単位元と逆元の左右両側、分配律の左右両側、0_ℝ ≠ 1_ℝ）を名前つきで並べた。引く側が使う別名（加法の可換律、和の可換律、積の結合律、乗法の交換律、積の可換律）も挙げた。一覧の −x と x^{-1} が写像の値であることを示すため、組に符号反転 −_ℝ と逆数 (·)^{-1}_ℝ を足して型を宣言した（逆元の一意性の主張に頼らない）。順序の公理の形と < の定義はまだ並べていない。",
        "2026-11-22（Lean の点検の直し、未定義の記号）: 本文の証明が名前だけで引いていた等号の反射律・対称律・推移律と、論理の記号（¬・∧・∨・⇒・⇔・⊥・∀・∃）と ≠ を、外から持ち込むと宣言し、証明が使う規則（直積の元の等号は成分ごと、写像の等号は点ごと、を含む）を名前つきで並べた。本文の証明が引く「行列の等号は成分ごと」も、行列の集合 Mat(m,n,ℂ) を定める定義のブロックがまだ無いので、外から持ち込む規則としてここに並べた。新しいブロックにせずここに足したのは、一対一の検査で対応する具体版の宣言の無いブロックを増やさないためである。",
        "2026-11-22（Lean の点検の直し、未定義の記号の行「ℝ の数・順序・差・商」のうち順序）: 本文の証明が「ℝ の順序の推移律（set_and_algebra_notation）」のように名前だけで引いていた ℝ の順序の性質を、反射律・反対称律・推移律・全順序・加法との両立・乗法との両立・上限の存在として名前つきで並べ、≥ を ≤ の略記と定めた（上限の存在は sqrt_nonnegative_existence_uniqueness などが使う箇所で宣言していた性質で、レビューの指摘で足した）。狭義の順序 < は def_real_strict_order で定める。これで Lean の ℝ の ≤・≥ は外から持ち込み使う性質を列挙した記号として、<・> は本文の定義との一致を補題一本で示した記号として、許可の一覧に載せられる。アルキメデス性は上限の存在から導ける主張なのでここに並べていない。一覧の行から導けるが主張として示していない順序の性質（狭義の順序と加法の両立、正の数どうしの積は正など）を set_and_algebra_notation の名前で引く箇所が残っており、状態台帳の行「ℝ の数・順序・差・商」に直す項目として書いた。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℕ の数・和・積・順序」のうち本文の宣言）: 組 ℕ の演算と順序について、外から持ち込み使う性質（和と積の再帰の式、後者の性質、数学的帰納法、加法・乗法の結合律・交換律・単位元、分配律、加法の簡約律、順序と和、順序の反射律・反対称律・推移律、全順序、順序と加法の両立）を名前つきで並べ、狭義の順序 x < y を x + 1 ≤ y、> と ≥ を逆向きの略記、x ≤ y のときの差 y − x を x + d = y を満たすただ一つの d と定め、十進の数字を「n を表す数字の次の数字は n + 1 を表す」と定めた。Lean の ℕ の < は Nat.lt n m := Nat.le (Nat.succ n) m で Nat.succ n は n + 1 と定義として等しく、数字 k+1 は k + 1 と定義として等しく、Lean の ℕ の差は x ≤ y の組でこの差と値が一致する（Nat.add_sub_cancel'。x ≤ y でない組では 0 を返す全域の写像で、その値は本文の定義の外）。新しいブロックにせずここに足したのは、一対一の検査で対応する具体版の宣言の無いブロックを増やさないためである。Lean の ℕ の記号はまだ許可の一覧に載せていない。本文の冪の指数・添字・帰納法の変数は ℤ_{≥k}（𝐙 の部分集合）の元として ℤ の演算で書かれており、Lean の ℕ との間の写像を置くまでは、許可すると ℕ と ℤ_{≥0} の暗黙の同一視が検査から見えなくなるからである（レビューの指摘）。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の先頭）: ℕ の上の写像を帰納法で定めるときに使う再帰による定義（任意の集合 X、a ∈ X、f: 𝐍×X → X について h(0) = a・h(n+1) = f(n, h(n)) を満たす h がただ一つある）を、外から持ち込むものとして宣言した。inclusion_nn_to_zz がこれを引く。Lean の具体版はこの存在を ℕ の再帰子 Nat.rec で受ける。inclusion_zz_to_rr・def_power_of_integer の ℤ_{≥0} の上の再帰は、ℤ_{≥0} と ℕ の間の写像の主張が揃ってからこの宣言へ移す。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の数・和・積・順序」）: 本文の証明が「ℤ の加法の結合律」「ℤ の分配律」「ℤ の和の単位元」などと名前だけで引いていた ℤ の性質の基になる性質を、外から持ち込み使う性質として名前つきで並べた（可換環の等式、0 ≠ 1、順序の反射律・反対称律・推移律・全順序、加法・乗法との両立、0 以上の元は 0 か 0 以上の元に 1 を足したもの、k から始める数学的帰納法）。引く側が使う別名（和の結合律、加法の可換律、和の単位元、加法逆元、積の単位元）も挙げた。一覧の −x が写像の値であることを示すため、組に符号反転 −_ℤ を足して型を宣言した。数字 0・1 は 0_ℤ・1_ℤ を表すと書いた。ℤ の差・狭義の順序・2 以上の数字は、1 ブロック 1 主張に従い ℝ と同じく別の定義のブロックで定める（状態台帳の行「ℤ の差・狭義の順序・数字」。2_ℤ は def_power_of_integer が既に定めている）。0 以上の元の分解と k から始める帰納法は、inclusion_zz_to_rr が ℤ_{≥0} の上の帰納的な定義に使い、本文の証明が ℤ_{≥1} の上の帰納法として使っていた性質である。一覧の行から導けるが一行ではない根拠（「ℤ の四則」「ℤ の符号反転を 2 回行うと元に戻る」「ℤ の減法」「ℤ の計算」、根拠の無い 1_ℤ ≥ 0_ℤ など）を名前だけで引く箇所が残っており、状態台帳の行「ℤ の差・狭義の順序・数字」に直す項目として書いた。新しいブロックにせずここに足したのは、一対一の検査で対応する具体版の宣言の無いブロックを増やさないためである。",
        "2026-11-24（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち ℤ の ≥）: ℤ の段に x ≥ y を y ≤ x の略記として足した。本文は ℤ の元どうしの ≥ を使っていたが（N_0 ≥ 1 など）、def_int_strict_order は < と > だけを定め、≥ を定めるブロックが無かった。Lean の ℤ の ≥ も y ≤ x と定義として等しい（GE.ge）。具体版の定義と主張には ℤ の ≥ が現れないので、許可の一覧は変えていない。",
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の二単位目）: 外から持ち込む規則に並べていた「行列の等号は成分ごとの等号」を消し、Mat(m,n,ℂ) を写像の全体と定める定義のブロック def_complex_matrices へ移した（行列の等号は写像の等号の規則の場合である）。この規則は Mat(m,n,ℂ) をその定義より前に使っていた。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_real_difference",
    kind: "definition",
    title: { text: "実数の差" },
    labels: ["def_real_difference"],
    lean: ["Ising2D.real_sub_eq_add_neg"],
    statement: [
      paragraph([
        math(String.raw`y, z \in \mathbb{R}`),
        " について、差 ",
        math(String.raw`y - z \in \mathbb{R}`),
        " を",
      ]),
      displayMath(String.raw`y - z := y + (-z)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`-z`),
        " は、",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " における ",
        math(String.raw`z`),
        " の加法の逆元 ",
        math(String.raw`-_{\mathbb{R}}(z)`),
        "（",
        math(String.raw`z + (-z) = 0_{\mathbb{R}}`),
        " を満たす）であり、和は ",
        math(String.raw`+_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。ℝ の差は本文全体で使われていたが、set_and_algebra_notation の ℝ の演算は和・積・零元・単位元・順序だけで、差を定めるブロックが無かった（def_A_theta の (1,1)・(2,2) 成分の差、real_inclusion_preserves_difference の右辺など）。ℂ の def_complex_difference と同じ形で足し、ℝ の差を最初に使う definition_of_cc より前（set_and_algebra_notation の直後）に置いた。符号反転は、本文の ℝ の計算（cos_of_negated_real の準備など）が加法の逆元として読んでいるので、ℂ の multiply_by_minus_one のように (-1) 倍で定めず、順序体の加法の逆元とした。",
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w30)。体の法則の式と名前を並べる件）: set_and_algebra_notation の ℝ の組に符号反転 −_ℝ を足したので、−z をその値 −_ℝ(z) として指す形にし、証明の要る「体の加法の逆元はただ一つに定まる」を消した。定義の式は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_real_strict_order",
    kind: "definition",
    title: { text: "実数の狭義の順序" },
    labels: ["def_real_strict_order"],
    lean: ["Ising2D.real_lt_iff_le_and_ne"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{R}`),
        " について、",
        math(String.raw`x < y`),
        " を",
      ]),
      displayMath(String.raw`x < y\ :\Leftrightarrow\ \bigl(x \le y\ \wedge\ x \neq y\bigr)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`\le`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序 ",
        math(String.raw`\le_{\mathbb{R}}`),
        "、",
        math(String.raw`\neq`),
        " は同じブロックの等号の否定である。",
        math(String.raw`x > y`),
        " は ",
        math(String.raw`y < x`),
        " の略記とする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-22（Lean の点検の直し、未定義の記号）: 原文（Typst）に対応ブロックは無い。< は本文全体で使われ、real_less_than_is_asymmetric が主張の中で「x < y は x ≤ y かつ x ≠ y のこと」と断っていたが、定めるブロックが無かった。def_real_difference と同じ形で、set_and_algebra_notation の直後の def_real_difference の後に置いた。Lean の具体版は Ising2D.real_lt_iff_le_and_ne（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionRealStrictOrder.lean）。mathlib の ℝ の < は ≤ から定めたものではないので、一致を補題一本で示す。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_integer_difference",
    kind: "definition",
    title: { text: "整数の差" },
    labels: ["def_int_difference"],
    lean: ["Ising2D.int_sub_eq_add_neg"],
    statement: [
      paragraph([
        math(String.raw`y, z \in \mathbb{Z}`),
        " について、差 ",
        math(String.raw`y -_{\mathbb{Z}} z \in \mathbb{Z}`),
        " を",
      ]),
      displayMath(String.raw`y -_{\mathbb{Z}} z := y +_{\mathbb{Z}} (-z)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`-z`),
        " は、",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転の値 ",
        math(String.raw`-_{\mathbb{Z}}(z)`),
        "（",
        math(String.raw`z +_{\mathbb{Z}} (-z) = 0_{\mathbb{Z}}`),
        " を満たす）であり、和は ",
        math(String.raw`+_{\mathbb{Z}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の差・狭義の順序・数字」）: 原文（Typst）に対応ブロックは無い。ℤ の差は本文全体で使われていたが、set_and_algebra_notation の ℤ の組は和・積・零元・単位元・符号反転・順序だけで、差を定めるブロックが無かった。def_real_difference と同じ形で、def_real_strict_order の後に置いた。ℤ の狭義の順序と 2 以上の数字は、それを引く最終定理の経路の証明と同じ回に別のブロックで定める（状態台帳の行「ℤ の狭義の順序・数字」）。Lean の具体版は Ising2D.int_sub_eq_add_neg（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionIntegerDifference.lean）。Lean の ℤ の差も y + -z と定義として等しい（rfl）。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_difference_plus_subtrahend_is_original",
    kind: "claim",
    title: { tex: String.raw`(x -_{\mathbb{Z}} y) +_{\mathbb{Z}} y = x` },
    labels: ["int_difference_plus_subtrahend_is_original"],
    lean: ["Ising2D.int_difference_plus_subtrahend_is_original"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`(x -_{\mathbb{Z}} y) +_{\mathbb{Z}} y = x`),
      paragraph([
        "である。差は ",
        ref("def_int_difference"),
        " のもの、和と ",
        math(String.raw`0_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-y`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転 ",
        math(String.raw`-_{\mathbb{Z}}(y)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x -_{\mathbb{Z}} y) +_{\mathbb{Z}} y
&= \bigl(x +_{\mathbb{Z}} (-y)\bigr) +_{\mathbb{Z}} y
&&\bigl(\because\ \blkref{def_int_difference}\ (y \to x,\ z \to y)\bigr)\\
&= x +_{\mathbb{Z}} \bigl((-y) +_{\mathbb{Z}} y\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (y \to -y,\ t \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= x +_{\mathbb{Z}} 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-x) + x = 0_{\mathbb{Z}}\ (x \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= x
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: 原文（Typst）に対応ブロックは無い。inclusion_zz_to_rr_preserves_sum・inclusion_zz_to_rr_preserves_product の証明が「ℤ の四則 b = (b − 1) + 1」「ℤ の四則 (x − a) + a = x」「ℤ の四則 (a + (b − 1)) + 1 = a + b」と名前だけで引いていた ℤ の等式の共通の部品として、def_int_difference と set_and_algebra_notation の ℤ の一覧の行（加法の結合律・加法の逆元・和の単位元）から示す主張として足した。Lean の具体版は Ising2D.int_difference_plus_subtrahend_is_original（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerDifferencePlusSubtrahendIsOriginal.lean）、必要十分版は Ising2D.NecSuf.sub_add_cancel_of_addGroup（NecSuf/SubAddCancelOfAddGroup.lean）。数値検証: sagemath/check/int_difference_plus_subtrahend_is_original/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_negation_of_sum_is_sum_of_negations",
    kind: "claim",
    title: { tex: String.raw`-_{\mathbb{Z}}(x +_{\mathbb{Z}} y) = (-_{\mathbb{Z}} x) +_{\mathbb{Z}} (-_{\mathbb{Z}} y)` },
    labels: ["int_negation_of_sum_is_sum_of_negations"],
    lean: ["Ising2D.int_negation_of_sum_is_sum_of_negations"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`-(x +_{\mathbb{Z}} y) = (-x) +_{\mathbb{Z}} (-y)`),
      paragraph([
        "である。和・符号反転 ",
        math(String.raw`-z = -_{\mathbb{Z}}(z)`),
        "・",
        math(String.raw`0_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
-(x + y)
&= \bigl(-(x + y)\bigr) + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ (x \to -(x + y))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(x + y)\bigr) + \bigl(x + (-x)\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ x + (-x) = 0_{\mathbb{Z}}\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(x + y)\bigr) + \bigl((x + 0_{\mathbb{Z}}) + (-x)\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(x + y)\bigr) + \Bigl(\bigl(x + (y + (-y))\bigr) + (-x)\Bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ x + (-x) = 0_{\mathbb{Z}}\ (x \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(x + y)\bigr) + \Bigl(\bigl((x + y) + (-y)\bigr) + (-x)\Bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (t \to -y)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(x + y)\bigr) + \Bigl((x + y) + \bigl((-y) + (-x)\bigr)\Bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to x + y,\ y \to -y,\ t \to -x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \Bigl(\bigl(-(x + y)\bigr) + (x + y)\Bigr) + \bigl((-y) + (-x)\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to -(x + y),\ y \to x + y,\ t \to (-y) + (-x))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} + \bigl((-y) + (-x)\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-x) + x = 0_{\mathbb{Z}}\ (x \to x + y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-y) + (-x)
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + x = x\ (x \to (-y) + (-x))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-x) + (-y)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換律}\ x + y = y + x\ (x \to -y,\ y \to -x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: 原文（Typst）に対応ブロックは無い。inclusion_zz_to_rr_of_successor の n = −(p + 1) の場合が「ℤ の四則 −(p + 1) + 1 = −p」と名前だけで引いていた等式の部品として、set_and_algebra_notation の ℤ の一覧の行（和の単位元・加法の逆元・加法の結合律・加法の交換律）だけから示す主張として足した。real_negation_of_sum_is_sum_of_negations は (−1)·z = −z を経る経路で示すが、ℤ の側には (−1)·z = −z の主張が無いので、加法だけの経路にした。Lean の具体版は Ising2D.int_negation_of_sum_is_sum_of_negations（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationOfSumIsSumOfNegations.lean）、必要十分版は Ising2D.NecSuf.neg_add_of_addCommGroup（NecSuf/NegAddOfAddCommGroup.lean）。数値検証: sagemath/check/int_negation_of_sum_is_sum_of_negations/。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_integer_strict_order",
    kind: "definition",
    title: { text: "整数の狭義の順序" },
    labels: ["def_int_strict_order"],
    lean: ["Ising2D.int_lt_iff_add_one_le"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{Z}`),
        " について、",
        math(String.raw`x <_{\mathbb{Z}} y`),
        " を",
      ]),
      displayMath(String.raw`x <_{\mathbb{Z}} y\ :\Leftrightarrow\ x +_{\mathbb{Z}} 1_{\mathbb{Z}} \le_{\mathbb{Z}} y`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`+_{\mathbb{Z}}`),
        "・",
        math(String.raw`1_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の和・乗法の単位元・順序である。",
        math(String.raw`\mathbb{Z}`),
        " の元どうしの ",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x <_{\mathbb{Z}} y`),
        " の略記、",
        math(String.raw`x > y`),
        " は ",
        math(String.raw`y < x`),
        " の略記とする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」）: 原文（Typst）に対応ブロックは無い。ℤ の < は本文で使われていたが（antiperiodic_exp_sum の「とくに」の |l| < 1 など）、set_and_algebra_notation の ℤ の組は ≤ だけで、< を定めるブロックが無かった。def_int_difference の後に置いた。ℝ の def_real_strict_order（x ≤ y かつ x ≠ y）と形が違うのは、ℤ では隣の元が 1 だけ離れていることをこの形が直接述べ、本文が引く「1 未満の 0 以上の整数は 0」をこの定義と set_and_algebra_notation の ℤ の行だけで書けるからである。Lean の具体版は Ising2D.int_lt_iff_add_one_le（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionIntegerStrictOrder.lean）。Lean の ℤ の < も x + 1 ≤ y と定義されており（Int.lt）、定義として等しい（Iff.rfl）。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_integer_absolute_value",
    kind: "definition",
    title: { text: "整数の絶対値" },
    labels: ["def_int_absolute_value"],
    lean: ["Ising2D.int_abs_of_nonneg_and_of_not_nonneg"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{Z}`),
        " について、絶対値 ",
        math(String.raw`|x| \in \mathbb{Z}`),
        " を",
      ]),
      displayMath(String.raw`|x| :=
\begin{cases}
  x & (0_{\mathbb{Z}} \le_{\mathbb{Z}} x), \\
  -_{\mathbb{Z}}(x) & (\neg\,(0_{\mathbb{Z}} \le_{\mathbb{Z}} x))
\end{cases}`),
      paragraph([
        "で定める。",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        "・",
        math(String.raw`-_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の零元・順序・符号反転、",
        math(String.raw`\neg`),
        " は同じく ",
        ref("set_and_algebra_notation"),
        " の否定である。どの ",
        math(String.raw`x`),
        " でも二つの場合の少なくとも一方が成り立ち（排中律）、両方は成り立たない（",
        math(String.raw`P`),
        " と ",
        math(String.raw`\neg P`),
        " から ",
        math(String.raw`\bot`),
        "）ので、",
        math(String.raw`|x|`),
        " は一つに定まる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち ℤ の絶対値）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」が ℤ の絶対値 |k|・|l|・|M_col| を使い、「絶対値は非負整数」「M_col > 0 なので |M_col| = M_col」を名前だけで引いていたが、ℤ の絶対値を定めるブロックが無かった。def_int_strict_order の後に置いた。Lean の具体版は Ising2D.int_abs_of_nonneg_and_of_not_nonneg（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionIntegerAbsoluteValue.lean）。mathlib の ℤ の |x| は束の上限 x ⊔ (−x) として定められており、場合分けの式と定義として等しくはないので、場合分けの二つの式が成り立つことを補題一本で示す。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_absolute_value_is_nonnegative",
    kind: "claim",
    title: { text: "整数の絶対値は 0 以上" },
    labels: ["int_absolute_value_is_nonnegative"],
    lean: ["Ising2D.int_absolute_value_is_nonnegative"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{Z}`),
        " について、",
        ref("def_int_absolute_value"),
        " の絶対値は",
      ]),
      displayMath(String.raw`0_{\mathbb{Z}} \le_{\mathbb{Z}} |x|`),
      paragraph([
        "を満たす。",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の零元・順序である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " の場合と、そうでない場合に分ける。",
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&\le x
&&\bigl(\because\ \text{場合の仮定}\ 0_{\mathbb{Z}} \le x\bigr)\\
&= |x|
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ 0_{\mathbb{Z}} \le x\ \text{の場合の式を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\neg\,(0_{\mathbb{Z}} \le x)`),
        " のとき、",
        math(String.raw`\mathbb{Z}`),
        " の全順序 ",
        math(String.raw`0_{\mathbb{Z}} \le x \vee x \le 0_{\mathbb{Z}}`),
        "（",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`x \to 0_{\mathbb{Z}},\ y \to x`),
        "）の左が成り立たないので ",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&= x + (-x)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ x + (-x) = 0_{\mathbb{Z}}\ (x \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&\le 0_{\mathbb{Z}} + (-x)
&&\bigl(\because\ x \le 0_{\mathbb{Z}}\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ x \le y \Rightarrow x + t \le y + t\ (x \to x,\ y \to 0_{\mathbb{Z}},\ t \to -x)\bigr)\\
&= -x
&&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + x = x\ (x \to -x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= |x|
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ \neg\,(0_{\mathbb{Z}} \le x)\ \text{の場合の式を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。どちらの場合も ", math(String.raw`0_{\mathbb{Z}} \le |x|`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち ℤ の絶対値）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」が「整数 l の絶対値は非負整数なので 0_ℤ ≤ |l|」と名前だけで引いていた性質を、def_int_absolute_value と set_and_algebra_notation の ℤ の行（全順序・加法の逆元・順序と加法の両立・和の単位元）から示す主張として足した。Lean の具体版は Ising2D.int_absolute_value_is_nonnegative（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueIsNonnegative.lean）、必要十分版は Ising2D.NecSuf.abs_nonneg_of_cases（NecSuf/AbsNonnegOfCases.lean）。数値検証: sagemath/check/int_absolute_value_is_nonnegative/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_absolute_value_zero_implies_zero",
    kind: "claim",
    title: { text: "絶対値が 0 の整数は 0" },
    labels: ["int_absolute_value_zero_implies_zero"],
    lean: ["Ising2D.int_absolute_value_zero_implies_zero"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{Z}`),
        " が ",
        ref("def_int_absolute_value"),
        " の絶対値について ",
        math(String.raw`|x| = 0_{\mathbb{Z}}`),
        " を満たすなら、",
      ]),
      displayMath(String.raw`x = 0_{\mathbb{Z}}`),
      paragraph([
        "である。",
        math(String.raw`0_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の零元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " の場合と、そうでない場合に分ける。",
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= |x|
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ 0_{\mathbb{Z}} \le x\ \text{の場合の式を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \text{主張の仮定}\ |x| = 0_{\mathbb{Z}}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\neg\,(0_{\mathbb{Z}} \le x)`),
        " のとき、まず",
      ]),
      displayMath(String.raw`\begin{aligned}
-x
&= |x|
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ \neg\,(0_{\mathbb{Z}} \le x)\ \text{の場合の式を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \text{主張の仮定}\ |x| = 0_{\mathbb{Z}}\bigr)
\end{aligned}`),
      paragraph(["であり、これを使うと"]),
      displayMath(String.raw`\begin{aligned}
x
&= x + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ (x \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= x + (-x)
&&\bigl(\because\ \text{上の}\ -x = 0_{\mathbb{Z}}\ \text{を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ x + (-x) = 0_{\mathbb{Z}}\ (x \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。どちらの場合も ", math(String.raw`x = 0_{\mathbb{Z}}`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち ℤ の絶対値）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」が「|l| = 0_ℤ なので l = 0」と名前だけで引いていた性質を、def_int_absolute_value と set_and_algebra_notation の ℤ の行（和の単位元・加法の逆元）から示す主張として足した。Lean の具体版は Ising2D.int_absolute_value_zero_implies_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueZeroImpliesZero.lean）、必要十分版は Ising2D.NecSuf.eq_zero_of_abs_cases_eq_zero（NecSuf/EqZeroOfAbsCasesEqZero.lean）。数値検証: sagemath/check/int_absolute_value_zero_implies_zero/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_zero_times_is_zero",
    kind: "claim",
    title: { text: "整数に 0 を左から掛けると 0 になる" },
    labels: ["int_zero_times_is_zero"],
    lean: ["Ising2D.int_zero_times_is_zero"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`0_{\mathbb{Z}} \cdot x = 0_{\mathbb{Z}}`),
      paragraph([
        "である。和・積・",
        math(String.raw`0_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-y`),
        "（",
        math(String.raw`y \in \mathbb{Z}`),
        "）は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転 ",
        math(String.raw`-_{\mathbb{Z}}(y)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}} \cdot x
&= 0_{\mathbb{Z}} \cdot x + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ y + 0_{\mathbb{Z}} = y\ (y \to 0_{\mathbb{Z}} \cdot x)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} \cdot x + \bigl(0_{\mathbb{Z}} \cdot x + (-(0_{\mathbb{Z}} \cdot x))\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ y + (-y) = 0_{\mathbb{Z}}\ (y \to 0_{\mathbb{Z}} \cdot x)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (0_{\mathbb{Z}} \cdot x + 0_{\mathbb{Z}} \cdot x) + (-(0_{\mathbb{Z}} \cdot x))
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (y + z) + t = y + (z + t)\ (y, z \to 0_{\mathbb{Z}} \cdot x,\ t \to -(0_{\mathbb{Z}} \cdot x))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (0_{\mathbb{Z}} + 0_{\mathbb{Z}}) \cdot x + (-(0_{\mathbb{Z}} \cdot x))
&&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ (y + z) \cdot t = y \cdot t + z \cdot t\ (y, z \to 0_{\mathbb{Z}},\ t \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} \cdot x + (-(0_{\mathbb{Z}} \cdot x))
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ y + 0_{\mathbb{Z}} = y\ (y \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ y + (-y) = 0_{\mathbb{Z}}\ (y \to 0_{\mathbb{Z}} \cdot x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち antiperiodic_exp_sum の「とくに」の名前だけの根拠）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」の鎖 k = lM_col = 0_ℤ·M_col = 0_ℤ が、最後の等号の根拠を「0_ℤ·M_col = 0_ℤ」と結論そのもので書いていた。0 を掛けると 0 になることは set_and_algebra_notation の ℤ の一覧の行に含まれないので、real_zero_times_is_zero と同じ手順で、その一覧の行（和の単位元・加法の逆元・加法の結合律・分配律）から示す主張として足した。Lean の具体版は Ising2D.int_zero_times_is_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerZeroTimesIsZero.lean）、必要十分版は real_zero_times_is_zero と同じ Ising2D.NecSuf.zero_mul_of_rightDistrib（NecSuf/ZeroMulOfRightDistrib.lean）。数値検証: sagemath/check/int_zero_times_is_zero/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_negation_times_is_negation_of_product",
    kind: "claim",
    title: { text: "符号を反転した整数に右から整数を掛けると、積の符号が反転する" },
    labels: ["int_negation_times_is_negation_of_product"],
    lean: ["Ising2D.int_negation_times_is_negation_of_product"],
    statement: [
      paragraph([
        math(String.raw`x, t \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`(-x) \cdot t = -(x \cdot t)`),
      paragraph([
        "である。和・積・符号反転は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-x) \cdot t
&= (-x) \cdot t + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ y + 0_{\mathbb{Z}} = y\ (y \to (-x) \cdot t)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (-x) \cdot t + \bigl(x \cdot t + (-(x \cdot t))\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ y + (-y) = 0_{\mathbb{Z}}\ (y \to x \cdot t)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl((-x) \cdot t + x \cdot t\bigr) + (-(x \cdot t))
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (y + z) + s = y + (z + s)\ (y \to (-x) \cdot t,\ z \to x \cdot t,\ s \to -(x \cdot t))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl((-x) + x\bigr) \cdot t + (-(x \cdot t))
&&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ (y + z) \cdot s = y \cdot s + z \cdot s\ (y \to -x,\ z \to x,\ s \to t)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} \cdot t + (-(x \cdot t))
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-y) + y = 0_{\mathbb{Z}}\ (y \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}} + (-(x \cdot t))
&&\bigl(\because\ \blkref{int_zero_times_is_zero}\ (x \to t)\bigr)\\
&= -(x \cdot t)
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to -(x \cdot t))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち antiperiodic_exp_sum の「とくに」の「積の絶対値」）: 原文（Typst）に対応ブロックは無い。int_absolute_value_of_product_with_nonnegative の証明が使う部品として足した。real_negation_times_is_negation_of_product は (−1)·x を経る経路で示すが、ℤ の側には (−1)·x = −x の主張が無いので、int_zero_times_is_zero と set_and_algebra_notation の ℤ の一覧の行（和の単位元・加法の逆元・加法の結合律・分配律）だけで示す。Lean の具体版は Ising2D.int_negation_times_is_negation_of_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationTimesIsNegationOfProduct.lean）、必要十分版は Ising2D.NecSuf.neg_mul_of_addGroup_rightDistrib（NecSuf/NegMulOfAddGroupRightDistrib.lean）。数値検証: sagemath/check/int_negation_times_is_negation_of_product/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_absolute_value_of_product_with_nonnegative",
    kind: "claim",
    title: { text: "0 以上の整数との積の絶対値" },
    labels: ["int_absolute_value_of_product_with_nonnegative"],
    lean: ["Ising2D.int_absolute_value_of_product_with_nonnegative"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{Z}`),
        " が ",
        math(String.raw`0_{\mathbb{Z}} \le y`),
        " を満たすなら、",
        ref("def_int_absolute_value"),
        " の絶対値について",
      ]),
      displayMath(String.raw`|x \cdot y| = |x| \cdot y`),
      paragraph([
        "である。積・",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " の場合と、そうでない場合に分ける。",
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " のとき、",
        math(String.raw`\mathbb{Z}`),
        " の順序と乗法の両立（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to x,\ y \to y`),
        "）に場合の仮定 ",
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " と主張の仮定 ",
        math(String.raw`0_{\mathbb{Z}} \le y`),
        " を使って ",
        math(String.raw`0_{\mathbb{Z}} \le x \cdot y`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
|x \cdot y|
&= x \cdot y
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ 0_{\mathbb{Z}} \le x\ \text{の場合の式}\ (x \to x \cdot y)\ \text{に、上の}\ 0_{\mathbb{Z}} \le x \cdot y\bigr)\\
&= |x| \cdot y
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ 0_{\mathbb{Z}} \le x\ \text{の場合の式}\ (x \to x)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\neg\,(0_{\mathbb{Z}} \le x)`),
        " のとき、まず",
      ]),
      displayMath(String.raw`\begin{aligned}
|x| \cdot y
&= (-x) \cdot y
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ \neg\,(0_{\mathbb{Z}} \le x)\ \text{の場合の式}\ (x \to x)\bigr)\\
&= -(x \cdot y)
&&\bigl(\because\ \blkref{int_negation_times_is_negation_of_product}\ (x \to x,\ t \to y)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        ref("int_absolute_value_is_nonnegative"),
        "（",
        math(String.raw`x \to x`),
        "）より ",
        math(String.raw`0_{\mathbb{Z}} \le |x|`),
        " であり、",
        math(String.raw`\mathbb{Z}`),
        " の順序と乗法の両立（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to |x|,\ y \to y`),
        "）と主張の仮定 ",
        math(String.raw`0_{\mathbb{Z}} \le y`),
        " から ",
        math(String.raw`0_{\mathbb{Z}} \le |x| \cdot y`),
        "、すなわち上の式で ",
        math(String.raw`0_{\mathbb{Z}} \le -(x \cdot y)`),
        " である。ここで ",
        math(String.raw`0_{\mathbb{Z}} \le x \cdot y`),
        " かどうかで分ける（排中律。",
        ref("set_and_algebra_notation"),
        "）。",
        math(String.raw`\neg\,(0_{\mathbb{Z}} \le x \cdot y)`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
|x \cdot y|
&= -(x \cdot y)
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ \neg\,(0_{\mathbb{Z}} \le x)\ \text{の場合の式}\ (x \to x \cdot y)\bigr)\\
&= |x| \cdot y
&&\bigl(\because\ \text{上の}\ |x| \cdot y = -(x \cdot y)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0_{\mathbb{Z}} \le x \cdot y`),
        " のとき、まず",
      ]),
      displayMath(String.raw`\begin{aligned}
x \cdot y
&= 0_{\mathbb{Z}} + x \cdot y
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + z = z\ (z \to x \cdot y)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le (-(x \cdot y)) + x \cdot y
&&\bigl(\because\ 0_{\mathbb{Z}} \le -(x \cdot y)\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to 0_{\mathbb{Z}},\ y \to -(x \cdot y),\ t \to x \cdot y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-z) + z = 0_{\mathbb{Z}}\ (z \to x \cdot y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        math(String.raw`\mathbb{Z}`),
        " の順序の反対称律（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to x \cdot y,\ y \to 0_{\mathbb{Z}}`),
        "）に ",
        math(String.raw`x \cdot y \le 0_{\mathbb{Z}}`),
        " と ",
        math(String.raw`0_{\mathbb{Z}} \le x \cdot y`),
        " を使って ",
        math(String.raw`x \cdot y = 0_{\mathbb{Z}}`),
        " である。これを使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
|x \cdot y|
&= x \cdot y
&&\bigl(\because\ \blkref{def_int_absolute_value}\ \text{の}\ 0_{\mathbb{Z}} \le x\ \text{の場合の式}\ (x \to x \cdot y)\ \text{に、場合の仮定}\ 0_{\mathbb{Z}} \le x \cdot y\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \text{上の}\ x \cdot y = 0_{\mathbb{Z}}\bigr)\\
&= x \cdot y + (-(x \cdot y))
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ z + (-z) = 0_{\mathbb{Z}}\ (z \to x \cdot y)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} + (-(x \cdot y))
&&\bigl(\because\ \text{上の}\ x \cdot y = 0_{\mathbb{Z}}\bigr)\\
&= -(x \cdot y)
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + z = z\ (z \to -(x \cdot y))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= |x| \cdot y
&&\bigl(\because\ \text{上の}\ |x| \cdot y = -(x \cdot y)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。どの場合も ", math(String.raw`|x \cdot y| = |x| \cdot y`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち antiperiodic_exp_sum の「とくに」の「積の絶対値」）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」が |lM_col| = |l||M_col| の根拠を「積の絶対値」と名前だけで引いていた（Lean は abs_mul）。本文が使うのは M_col ≥ 0 の形だけなので、0 ≤ y の形に限った主張として足し、「とくに」の 2 行 |lM_col| = |l||M_col| = |l|M_col をこの主張の 1 行にした。証明は def_int_absolute_value の場合分け、int_absolute_value_is_nonnegative、int_negation_times_is_negation_of_product と set_and_algebra_notation の ℤ の一覧の行（順序と乗法の両立・順序と加法の両立・反対称律・和の単位元・加法の逆元・排中律）による。Lean の具体版は Ising2D.int_absolute_value_of_product_with_nonnegative（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueOfProductWithNonnegative.lean）、必要十分版は Ising2D.NecSuf.abs_mul_of_nonneg_right_of_cases（NecSuf/AbsMulOfNonnegRightOfCases.lean）。数値検証: sagemath/check/int_absolute_value_of_product_with_nonnegative/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_zero_at_most_one",
    kind: "claim",
    title: { text: "整数の 0 は 1 以下" },
    labels: ["int_zero_at_most_one"],
    lean: ["Ising2D.int_zero_at_most_one"],
    statement: [
      displayMath(String.raw`0_{\mathbb{Z}} \le_{\mathbb{Z}} 1_{\mathbb{Z}}`),
      paragraph([
        "である。",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`1_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の零元・乗法の単位元・順序である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-y`),
        "（",
        math(String.raw`y \in \mathbb{Z}`),
        "）は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転 ",
        math(String.raw`-_{\mathbb{Z}}(y)`),
        " である。",
        math(String.raw`\mathbb{Z}`),
        " の全順序 ",
        math(String.raw`0_{\mathbb{Z}} \le 1_{\mathbb{Z}} \vee 1_{\mathbb{Z}} \le 0_{\mathbb{Z}}`),
        "（",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`x \to 0_{\mathbb{Z}},\ y \to 1_{\mathbb{Z}}`),
        "）で分ける。",
        math(String.raw`0_{\mathbb{Z}} \le 1_{\mathbb{Z}}`),
        " のときは主張そのものである。",
        math(String.raw`1_{\mathbb{Z}} \le 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&= 1_{\mathbb{Z}} + (-1_{\mathbb{Z}})
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ y + (-y) = 0_{\mathbb{Z}}\ (y \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le 0_{\mathbb{Z}} + (-1_{\mathbb{Z}})
&&\bigl(\because\ 1_{\mathbb{Z}} \le 0_{\mathbb{Z}}\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to 1_{\mathbb{Z}},\ y \to 0_{\mathbb{Z}},\ t \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\mathbb{Z}`),
        " の順序と乗法の両立（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x, y \to -1_{\mathbb{Z}}`),
        "）に ",
        math(String.raw`0_{\mathbb{Z}} \le -1_{\mathbb{Z}}`),
        " を二度使って ",
        math(String.raw`0_{\mathbb{Z}} \le (-1_{\mathbb{Z}}) \cdot (-1_{\mathbb{Z}})`),
        " である。これを使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&\le (-1_{\mathbb{Z}}) \cdot (-1_{\mathbb{Z}})
&&\bigl(\because\ \text{上の}\ 0_{\mathbb{Z}} \le (-1_{\mathbb{Z}}) \cdot (-1_{\mathbb{Z}})\bigr)\\
&= -\bigl(1_{\mathbb{Z}} \cdot (-1_{\mathbb{Z}})\bigr)
&&\bigl(\because\ \blkref{int_negation_times_is_negation_of_product}\ (x \to 1_{\mathbb{Z}},\ t \to -1_{\mathbb{Z}})\bigr)\\
&= -(-1_{\mathbb{Z}})
&&\bigl(\because\ \mathbb{Z}\ \text{の乗法の単位元}\ 1_{\mathbb{Z}} \cdot y = y\ (y \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -(-1_{\mathbb{Z}}) + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ y + 0_{\mathbb{Z}} = y\ (y \to -(-1_{\mathbb{Z}}))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= -(-1_{\mathbb{Z}}) + \bigl((-1_{\mathbb{Z}}) + 1_{\mathbb{Z}}\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-y) + y = 0_{\mathbb{Z}}\ (y \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(-(-1_{\mathbb{Z}}) + (-1_{\mathbb{Z}})\bigr) + 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (y + z) + s = y + (z + s)\ (y \to -(-1_{\mathbb{Z}}),\ z \to -1_{\mathbb{Z}},\ s \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0_{\mathbb{Z}} + 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-y) + y = 0_{\mathbb{Z}}\ (y \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。どちらの場合も ", math(String.raw`0_{\mathbb{Z}} \le 1_{\mathbb{Z}}`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち antiperiodic_exp_sum の「とくに」の「正数倍は狭義順序を反映する」）: 原文（Typst）に対応ブロックは無い。int_less_than_one_of_product_less_than_nonnegative_factor の証明が、1_ℤ ≤ 0_ℤ から矛盾を導くのに使う部品として足した。set_and_algebra_notation の ℤ の一覧の行は 0_ℤ ≤ 1_ℤ を含まないので、全順序で分け、1_ℤ ≤ 0_ℤ の側では順序と乗法の両立で (−1)·(−1) が 0 以上になることから示す。Lean の具体版は Ising2D.int_zero_at_most_one（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerZeroAtMostOne.lean）、必要十分版は Ising2D.NecSuf.zero_le_one_of_cases（NecSuf/ZeroLeOneOfCases.lean）。数値検証: sagemath/check/int_zero_at_most_one/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_integer_less_than_one_of_product_less_than_nonnegative_factor",
    kind: "claim",
    title: { text: "0 以上の整数 c について x·c < c なら x < 1" },
    labels: ["int_less_than_one_of_product_less_than_nonnegative_factor"],
    lean: ["Ising2D.int_less_than_one_of_product_less_than_nonnegative_factor"],
    statement: [
      paragraph([
        math(String.raw`x, c \in \mathbb{Z}`),
        " が ",
        math(String.raw`0_{\mathbb{Z}} \le c`),
        " と ",
        ref("def_int_strict_order"),
        " の狭義の順序について ",
        math(String.raw`x \cdot c < c`),
        " を満たすなら、",
      ]),
      displayMath(String.raw`x < 1_{\mathbb{Z}}`),
      paragraph([
        "である。積・",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`1_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-y`),
        "（",
        math(String.raw`y \in \mathbb{Z}`),
        "）は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転 ",
        math(String.raw`-_{\mathbb{Z}}(y)`),
        " である。まず ",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " を示す。",
        math(String.raw`\mathbb{Z}`),
        " の全順序 ",
        math(String.raw`x \le 0_{\mathbb{Z}} \vee 0_{\mathbb{Z}} \le x`),
        "（",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`x \to x,\ y \to 0_{\mathbb{Z}}`),
        "）で分ける。",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " のときはそれである。",
        math(String.raw`0_{\mathbb{Z}} \le x`),
        " のとき、",
        math(String.raw`\mathbb{Z}`),
        " の ",
        math(String.raw`0_{\mathbb{Z}}`),
        " 以上の元の分解（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to x`),
        "）により、",
        math(String.raw`x = 0_{\mathbb{Z}}`),
        " であるか、",
        math(String.raw`0_{\mathbb{Z}} \le n`),
        " かつ ",
        math(String.raw`x = n + 1_{\mathbb{Z}}`),
        " を満たす ",
        math(String.raw`n \in \mathbb{Z}`),
        " がある。",
        math(String.raw`x = 0_{\mathbb{Z}}`),
        " のときは、",
        math(String.raw`\mathbb{Z}`),
        " の順序の反射律 ",
        math(String.raw`0_{\mathbb{Z}} \le 0_{\mathbb{Z}}`),
        "（",
        ref("set_and_algebra_notation"),
        "）の左辺を、等しいものの代入（",
        ref("set_and_algebra_notation"),
        "）で ",
        math(String.raw`x`),
        " に替えて ",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " である。",
        math(String.raw`x = n + 1_{\mathbb{Z}}`),
        " のとき、",
        math(String.raw`\mathbb{Z}`),
        " の順序と乗法の両立（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to n,\ y \to c`),
        "）に ",
        math(String.raw`0_{\mathbb{Z}} \le n`),
        " と主張の仮定 ",
        math(String.raw`0_{\mathbb{Z}} \le c`),
        " を使って ",
        math(String.raw`0_{\mathbb{Z}} \le n \cdot c`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
c
&= 0_{\mathbb{Z}} + c
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le n \cdot c + c
&&\bigl(\because\ 0_{\mathbb{Z}} \le n \cdot c\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to 0_{\mathbb{Z}},\ y \to n \cdot c,\ t \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= n \cdot c + 1_{\mathbb{Z}} \cdot c
&&\bigl(\because\ \mathbb{Z}\ \text{の乗法の単位元}\ 1_{\mathbb{Z}} \cdot y = y\ (y \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (n + 1_{\mathbb{Z}}) \cdot c
&&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ (y + z) \cdot s = y \cdot s + z \cdot s\ (y \to n,\ z \to 1_{\mathbb{Z}},\ s \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= x \cdot c
&&\bigl(\because\ \text{場合の仮定}\ x = n + 1_{\mathbb{Z}}\ \text{を右辺から左辺へ、等しいものの代入（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。主張の仮定 ",
        math(String.raw`x \cdot c < c`),
        " は ",
        ref("def_int_strict_order"),
        "（",
        math(String.raw`x \to x \cdot c,\ y \to c`),
        "）により ",
        math(String.raw`x \cdot c + 1_{\mathbb{Z}} \le c`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
c + 1_{\mathbb{Z}}
&\le x \cdot c + 1_{\mathbb{Z}}
&&\bigl(\because\ \text{上の}\ c \le x \cdot c\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to c,\ y \to x \cdot c,\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&\le c
&&\bigl(\because\ \text{上の}\ x \cdot c + 1_{\mathbb{Z}} \le c\ \text{と}\ \mathbb{Z}\ \text{の順序の推移律}\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。これを使うと"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{Z}}
&= 0_{\mathbb{Z}} + 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl((-c) + c\bigr) + 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-y) + y = 0_{\mathbb{Z}}\ (y \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (-c) + (c + 1_{\mathbb{Z}})
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (y + z) + s = y + (z + s)\ (y \to -c,\ z \to c,\ s \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (c + 1_{\mathbb{Z}}) + (-c)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換律}\ y + z = z + y\ (y \to -c,\ z \to c + 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&\le c + (-c)
&&\bigl(\because\ \text{上の}\ c + 1_{\mathbb{Z}} \le c\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to c + 1_{\mathbb{Z}},\ y \to c,\ t \to -c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ y + (-y) = 0_{\mathbb{Z}}\ (y \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\mathbb{Z}`),
        " の順序の反対称律（",
        ref("set_and_algebra_notation"),
        "。",
        math(String.raw`x \to 0_{\mathbb{Z}},\ y \to 1_{\mathbb{Z}}`),
        "）に ",
        ref("int_zero_at_most_one"),
        " の ",
        math(String.raw`0_{\mathbb{Z}} \le 1_{\mathbb{Z}}`),
        " と上の ",
        math(String.raw`1_{\mathbb{Z}} \le 0_{\mathbb{Z}}`),
        " を使うと ",
        math(String.raw`0_{\mathbb{Z}} = 1_{\mathbb{Z}}`),
        " となり、",
        math(String.raw`\mathbb{Z}`),
        " の零元と単位元の相違 ",
        math(String.raw`0_{\mathbb{Z}} \neq 1_{\mathbb{Z}}`),
        "（",
        ref("set_and_algebra_notation"),
        "）と合わせて ",
        math(String.raw`\bot`),
        " である。偽からは任意の命題が従う（",
        ref("set_and_algebra_notation"),
        "）ので、この場合も ",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " である。どの場合も ",
        math(String.raw`x \le 0_{\mathbb{Z}}`),
        " が成り立つので、",
      ]),
      displayMath(String.raw`\begin{aligned}
x + 1_{\mathbb{Z}}
&\le 0_{\mathbb{Z}} + 1_{\mathbb{Z}}
&&\bigl(\because\ x \le 0_{\mathbb{Z}}\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to x,\ y \to 0_{\mathbb{Z}},\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + y = y\ (y \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_int_strict_order"),
        "（",
        math(String.raw`x \to x,\ y \to 1_{\mathbb{Z}}`),
        "）により ",
        math(String.raw`x < 1_{\mathbb{Z}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち antiperiodic_exp_sum の「とくに」の「正数倍は狭義順序を反映する」）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の「とくに」が |l|M_col < M_col から |l| < 1 を「M_col > 0 なので、整数における正数倍は狭義順序を反映する」と名前だけの根拠で導いていた（M_col > 0 自体も示していなかった）。本文が使う形だけを、仮定を 0 ≤ c に弱めた主張として足した（c = 0 では仮定 x·c < c が成り立たない）。証明は set_and_algebra_notation の ℤ の一覧の行（全順序・0 以上の元の分解・反射律・順序と乗法の両立・和の単位元・乗法の単位元・分配律・順序と加法の両立・推移律・加法の逆元・結合律・交換律・反対称律・零元と単位元の相違・偽からは任意の命題が従う）と def_int_strict_order と int_zero_at_most_one だけを使う。Lean の具体版は Ising2D.int_less_than_one_of_product_less_than_nonnegative_factor（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactor.lean）、必要十分版は Ising2D.NecSuf.lt_one_of_mul_lt_self_of_cases（NecSuf/LtOneOfMulLtSelfOfCases.lean）。数値検証: sagemath/check/int_less_than_one_of_product_less_than_nonnegative_factor/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_real_less_than_preserved_by_adding_on_right",
    kind: "claim",
    title: { text: "実数の狭義の順序は右から同じ数を足しても保たれる" },
    labels: ["real_less_than_preserved_by_adding_on_right"],
    lean: ["Ising2D.real_less_than_preserved_by_adding_on_right"],
    statement: [
      paragraph([
        math(String.raw`x, y, c \in \mathbb{R}`),
        " とする。和・順序 ",
        math(String.raw`\leq`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`<`),
        " は ",
        ref("def_real_strict_order"),
        " の狭義の順序である。",
        math(String.raw`x < y`),
        " ならば",
      ]),
      displayMath(String.raw`x + c < y + c`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`x < y`),
        " の定義（",
        ref("def_real_strict_order"),
        "）から ",
        math(String.raw`x \leq y`),
        " と ",
        math(String.raw`x \neq y`),
        " である。",
        math(String.raw`-c \in \mathbb{R}`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to c`),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
x + c
&\leq y + c
&&\bigl(\because\ x \leq y\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x \leq y \Rightarrow x + t \leq y + t\ (x \to x,\ y \to y,\ t \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`x + c = y + c`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= x + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= x + (c + (-c))
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to c)\ \text{を右辺から左辺へ}\bigr)\\
&= (x + c) + (-c)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to x,\ y \to c,\ t \to -c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= (y + c) + (-c)
&&\bigl(\because\ \text{仮定}\ x + c = y + c\bigr)\\
&= y + (c + (-c))
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to y,\ y \to c,\ t \to -c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= y + 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to c)\bigr)\\
&= y
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`x \neq y`),
        " に反する。よって ",
        math(String.raw`x + c \neq y + c`),
        " であり、上の ",
        math(String.raw`x + c \leq y + c`),
        " と合わせて、",
        ref("def_real_strict_order"),
        " から ",
        math(String.raw`x + c < y + c`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℝ の数・順序・差・商」のうち順序の (a)）: 原文（Typst）に対応ブロックは無い。set_and_algebra_notation の順序の条件が述べる加法との両立は ≤ についてだけなのに、pi_is_positive・real_zero_less_than_one・real_zero_less_than_two・real_inverse_of_positive_is_positive（2 か所）・real_negation_of_positive_is_negative・angle_section_of_principal_angle_plus_half_pi の 7 か所が狭義の順序の形 x < y ⇒ x + c < y + c を「ℝ の順序と加法の両立（ℝ は順序体）」として名前だけで引いていたので、≤ の両立と体の加法の法則と def_real_strict_order から示す主張として足し、7 か所の根拠をこのブロックへの参照に替えた。左から足す形 c + x < c + y は別に扱う。Lean の具体版は Ising2D.real_less_than_preserved_by_adding_on_right（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanPreservedByAddingOnRight.lean）、必要十分版は Ising2D.NecSuf.add_lt_add_right_of_le_compat（NecSuf/AddLtAddRightOfLeCompat.lean）。数値検証: sagemath/check/real_less_than_preserved_by_adding_on_right/。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_real_quotient",
    kind: "definition",
    title: { text: "実数の商" },
    labels: ["def_real_quotient"],
    lean: ["Ising2D.real_div_eq_mul_inv"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        "、",
        math(String.raw`z \in \mathbb{R}`),
        "、",
        math(String.raw`z \neq 0_{\mathbb{R}}`),
        " について、商 ",
        math(String.raw`\dfrac{y}{z} \in \mathbb{R}`),
        " を",
      ]),
      displayMath(String.raw`\frac{y}{z} := y\,z^{-1}`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`z^{-1}`),
        " は、",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " における ",
        math(String.raw`z`),
        " の乗法の逆元 ",
        math(String.raw`(z)^{-1}_{\mathbb{R}}`),
        "（",
        math(String.raw`z\,z^{-1} = 1_{\mathbb{R}}`),
        " を満たす）であり、積は ",
        math(String.raw`\cdot_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。ℝ の分数は本文全体で使われていたが、set_and_algebra_notation の ℝ の演算は和・積・零元・単位元・順序だけで、商を定めるブロックが無く、periodicity_of_check_fermi (2) の θ̃_{μ+kM} の鎖が「(M_col)_ℝ ≠ 0_ℝ を分母とする分数の和」「約分」を名前だけで当てていた。一ステップ一定理に割るために、ℂ の def_complex_quotient と同じ形で def_real_difference の直後に足した。",
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w30)。体の法則の式と名前を並べる件）: set_and_algebra_notation の ℝ の組に逆数 (·)^{-1}_ℝ を足したので、z^{-1} をその値 (z)^{-1}_ℝ として指す形にし、証明の要る「0_ℝ でない元の乗法の逆元はただ一つに定まる」を消した。定義の式は不変。",
        "2026-11-23（Lean の点検の直し、未定義の記号）: 欄 lean に具体版 Ising2D.real_div_eq_mul_inv（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionRealQuotient.lean。z ≠ 0 を仮定に置いた y/z = y z^{-1}）を書いた。Lean の / と ⁻¹ は 0 でも値を持つ全域の写像で、この定義の商と set_and_algebra_notation の逆数はその ℝ∖{0} への制限に当たる。逆元の式 z z^{-1} = 1_ℝ は同じファイルの Ising2D.real_mul_inv_cancel で読む。定義の式は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_real_two",
    kind: "definition",
    title: { text: "実数の 2" },
    labels: ["def_real_two"],
    lean: ["Ising2D.real_two_eq_one_add_one"],
    statement: [
      paragraph([
        "本文で ",
        math(String.raw`\mathbb{R}`),
        " の元として書く ",
        math(String.raw`2 \in \mathbb{R}`),
        " を",
      ]),
      displayMath(String.raw`2 := 1 + 1`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " の乗法の単位元 ",
        math(String.raw`1_{\mathbb{R}}`),
        "、和は ",
        math(String.raw`+_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。本文は ℝ の 2 を def_real_quotient の分母（π/2 など）や係数に使い、0 < 2・2 ≠ 0・1 + 1 = 2 を名前だけで根拠にしていたが、set_and_algebra_notation は ℝ の元として 0_ℝ・1_ℝ しか挙げず、2 を定めるブロックが無かった。def_real_difference・def_real_quotient と同じく set_and_algebra_notation の直後の定義の並びに置いた。0 < 2 は real_zero_less_than_two で示す。Lean では ℝ の数字 2 を mathlib の one_add_one_eq_two（1 + 1 = 2）で読む。",
        "2026-11-22（Lean の点検の直し、未定義の記号の行「ℝ の数・順序・差・商」のうち数 2）: Lean の具体版を Ising2D.real_two_eq_one_add_one（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionRealTwo.lean）とし、欄 lean に書いた。mathlib の ℝ の数字 2 は Nat.cast 2 を通して定められており 1 + 1 と定義として等しくないので、一致を補題一本で示す。定義の式は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_000c0_claim_positive_real_square_injective",
    kind: "claim",
    title: { text: "正の実数の二乗の一意性" },
    labels: ["positive_real_square_injective"],
    lean: ["Ising2D.positive_real_square_injective", "Ising2D.factor_difference_of_squares_eq_zero"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}_{>0}`),
        " について",
      ]),
      displayMath(String.raw`a^2 = b^2 \iff a = b`),
      paragraph([
        "が成り立つ。二乗 ",
        math(String.raw`a^2`),
        "・",
        math(String.raw`b^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。",
      ]),
    ],
    proof: [
      paragraph(["両方向を別々に示すので、ここは一続きの式にしない。"]),
      displayMath(String.raw`\begin{aligned}
a=b
&\Longrightarrow a^2=b^2
&&(\because\ a^2\ \text{の}\ a\ \text{へ}\ a = b\ \text{を代入する})
\end{aligned}`),
      paragraph([
        "逆に ",
        math(String.raw`a^2 = b^2`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a - b)(a + b)
&= (a - b)\,a + (a - b)\,b
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= (a\,a - b\,a) + (a\,b - b\,b)
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= (a\,a - a\,b) + (a\,b - b\,b)
&&(\because\ \mathbb{R}\ \text{の乗法の交換律}\ b\,a = a\,b)\\
&= a\,a - b\,b
&&(\because\ -a\,b\ \text{と}\ a\,b\ \text{が打ち消し合う})\\
&= a^2 - b\,b
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= a^2 - b^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= b^2 - b^2
&&(\because\ a^2 = b^2)\\
&= 0
&&(\because\ b^2\ \text{は}\ \mathbb{R}\ \text{の加法で自身の逆元と足すと}\ 0)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a>0\ \land\ b>0
&\Longrightarrow a+b>0
&&(\because\ \text{正の実数の和は正})\\
&\Longrightarrow a+b\ne0
&&(\because\ \text{正の実数は }0\text{ でない})\\
(a-b)(a+b)=0\ \land\ a+b\ne0
&\Longrightarrow a-b=0
&&(\because\ \mathbb R\text{ は整域})\\
&\Longrightarrow a=b
&&(\because\ \text{両辺に }b\text{ を加える})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "順序体の性質であり双曲線関数とは無関係なので、双曲線関数の基本性質 (4) から独立させた。非負実数の平方根の存在と一意性がこれを引くことで、平方根→行列ノルム→行列の exp→数の exp→双曲線関数→平方根という依存の循環を断つ。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 主張の二乗 a^2・b^2 が def_power_of_real_number の冪（m = 2）か積かを書いていなかったので、冪と明記した。名前だけの根拠「等しい実数を二乗しても等しい」を代入の行に、「2 乗の差の因数分解」の 1 行を、分配法則 2 回・乗法の交換法則・打ち消し・square_of_real_number_is_product（r → a、r → b）の 6 行に割った。a^2 − b^2 = 0 の行も、a^2 = b^2 の代入と b^2 − b^2 = 0 の 2 行に割った。square_of_real_number_is_product と def_power_of_real_number は平方根を使わないので循環しない（どちらも文書の並びでは後に来る）。主張と値は変えていない。",
      ],
    },
  },
  {
    id: "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { tex: String.raw`\text{非負実数の平方根の存在と一意性}` },
    labels: ["sqrt_nonnegative_existence_uniqueness"],
    statement: [
      paragraph([
        math(String.raw`x\in\mathbb{R}_{\ge 0}`),
        " について、",
      ]),
      displayMath(String.raw`y\in\mathbb{R}_{\ge 0} \ \land\ y^2=x`),
      paragraph([
        "を満たす ", math(String.raw`y`), " がただ一つ存在する。二乗 ",
        math(String.raw`y^2`), " は ", ref("def_power_of_real_number"), " の冪（",
        math(String.raw`m = 2`), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "ここで初めて非可算集合 ",
        math(String.raw`\mathbb{R}`),
        " の完備性（上限性質）へ移行する。すなわち、以下では ",
        math(String.raw`\mathbb{R}`),
        " が「上に有界で空でない部分集合が必ず上限（最小上界）をもつ順序体」であるという性質を使う。",
        "有理数体 ",
        math(String.raw`\mathbb{Q}`),
        " はこの性質をもたない（",
        math(String.raw`x=2`),
        " のとき ",
        math(String.raw`y^2=2`),
        " なる ",
        math(String.raw`y\in\mathbb{Q}`),
        " は存在しない）ので、存在の主張は ",
        math(String.raw`\mathbb{R}`),
        " へ移行しなければ成り立たない。一方、一意性は順序体の代数だけで示せる。",
      ]),
      paragraph([
        "一意性。",
        math(String.raw`y_1,y_2\in\mathbb{R}_{\ge 0}`),
        " がともに ",
        math(String.raw`y_1^2=x`),
        "、",
        math(String.raw`y_2^2=x`),
        " を満たすとする。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " の場合と ",
        math(String.raw`x>0`),
        " の場合に分ける。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
y_1^2
&= x
&&(\because\ y_1\ \text{の仮定})\\
&= 0
&&(\because\ \text{いまの場合分け})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\mathbb{R}`),
        " は整域だから ",
        math(String.raw`y_1=0`),
        " である。",
        math(String.raw`y_2`),
        " についても同じ議論で ",
        math(String.raw`y_2=0`),
        " なので ",
        math(String.raw`y_1=y_2`),
        " である。",
      ]),
      paragraph([
        math(String.raw`x>0`),
        " のとき。まず ",
        math(String.raw`y_1>0`),
        " である。実際 ",
        math(String.raw`y_1=0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= y_1^2
&&(\because\ y_1\ \text{の仮定})\\
&= 0^2
&&(\because\ \text{仮定}\ y_1=0)\\
&= 0
&&(\because\ 0\ \text{の冪})
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`x>0`),
        " に矛盾する。",
        math(String.raw`y_1\in\mathbb{R}_{\ge0}`),
        " なので ",
        math(String.raw`y_1>0`),
        " である。",
        math(String.raw`y_2`),
        " についても同じ議論で ",
        math(String.raw`y_2>0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
y_1^2
&= x
&&(\because\ y_1\ \text{の仮定})\\
&= y_2^2
&&(\because\ y_2\ \text{の仮定})
\end{aligned}`),
      paragraph([
        "と ",
        ref("positive_real_square_injective"),
        "（",
        math(String.raw`a,b\in\mathbb{R}_{>0}`),
        " について ",
        math(String.raw`a^2=b^2\iff a=b`),
        "）より ",
        math(String.raw`y_1=y_2`),
        " である。",
      ]),
      paragraph([
        "存在。",
        math(String.raw`x=0`),
        " のときは ",
        math(String.raw`y:=0`),
        " と置けば ",
        math(String.raw`y\ge 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
y^2
&= 0^2
&&(\because\ y\ \text{の定め方})\\
&= 0
&&(\because\ 0\ \text{の冪})\\
&= x
&&(\because\ \text{いまの場合分け})
\end{aligned}`),
      paragraph([
        "を満たす。以下 ",
        math(String.raw`x>0`),
        " とし、",
      ]),
      displayMath(String.raw`S:=\left\{\,s\in\mathbb{R}_{\ge 0} \;\middle|\; s^2\le x\,\right\}\subset\mathbb{R}`),
      paragraph([
        "とおく。",
        math(String.raw`0\in S`),
        " を確かめると、",
      ]),
      displayMath(String.raw`\begin{aligned}
0^2
&=0
&&(\because\ 0\ \text{の冪})\\
&\le x
&&(\because\ x\in\mathbb{R}_{\ge0})
\end{aligned}`),
      paragraph([
        "より ",
        math(String.raw`S\neq\emptyset`),
        "。また ",
        math(String.raw`1+x`),
        " は ",
        math(String.raw`S`),
        " の上界である。実際、",
        math(String.raw`s\in S`),
        " かつ ",
        math(String.raw`s>1+x`),
        " と仮定すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
s>1+x\ \land\ 1+x>1
&\Longrightarrow s>1
&&(\because\ \mathbb{R}\ \text{の順序の推移律。}\ 1+x>1\ \text{は}\ x>0\ \text{による})
\end{aligned}`),
      paragraph([
        "であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
s^2
&= s\cdot s
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to s)\bigr)\\
&> (1+x)\cdot 1
&&(\because\ s>1+x>0\ \text{と}\ s>1>0\text{、順序体の乗法の単調性})\\
&= 1+x
&&(\because\ 1\ \text{は乗法の単位元})\\
&> x
&&(\because\ 1>0)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`s^2\le x`),
        " に矛盾する。よって ",
        math(String.raw`S`),
        " は空でなく上に有界であるから、",
        math(String.raw`\mathbb{R}`),
        " の上限性質により ",
        math(String.raw`y:=\sup S\in\mathbb{R}`),
        " が定まる。",
        math(String.raw`0\in S`),
        " より ",
        math(String.raw`y\ge 0`),
        "。",
      ]),
      paragraph([
        "この ",
        math(String.raw`y`),
        " について ",
        math(String.raw`y^2=x`),
        " を示す。三分律により ",
        math(String.raw`y^2<x`),
        "、",
        math(String.raw`y^2>x`),
        "、",
        math(String.raw`y^2=x`),
        " のいずれか一つが成り立つので、初めの 2 つが矛盾を導くことを示せばよい。",
      ]),
      paragraph([
        "(a) ",
        math(String.raw`y^2<x`),
        " と仮定する。",
          math(String.raw`\varepsilon:=\min\left\{1,\ \dfrac{x-y^2}{2y+1}\right\}\in\mathbb{R}`),
          " とおく（",
          math(String.raw`2y+1\ge 1>0`),
          " なので商は定義され、",
          math(String.raw`x-y^2>0`),
          " より ",
          math(String.raw`\varepsilon>0`),
          "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^2
&= \varepsilon\cdot\varepsilon
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \varepsilon)\bigr)\\
&\le 1\cdot\varepsilon
&&(\because\ \varepsilon\le 1,\ \varepsilon>0\text{、順序体の乗法の単調性})\\
&= \varepsilon
&&(\because\ 1\ \text{は乗法の単位元})
\end{aligned}`),
      paragraph([
        "であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y+\varepsilon)^2
&= y^2+2y\varepsilon+\varepsilon^2
&&(\because\ \text{分配律})\\
&\le y^2+2y\varepsilon+\varepsilon
&&(\because\ \varepsilon^2\le\varepsilon)\\
&= y^2+(2y+1)\varepsilon
&&(\because\ \text{分配律})\\
&\le y^2+(2y+1)\cdot\frac{x-y^2}{2y+1}
&&\left(\because\ \varepsilon\le\frac{x-y^2}{2y+1},\ 2y+1>0\right)\\
&= y^2+(x-y^2)
&&(\because\ 2y+1\ne0\ \text{による約分})\\
&= x
&&(\because\ \mathbb{R}\ \text{の加法の結合性と逆元})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`y+\varepsilon\in S`),
        " であり ",
        math(String.raw`y+\varepsilon>y=\sup S`),
        " となって、",
        math(String.raw`y`),
        " が ",
        math(String.raw`S`),
        " の上界であることに矛盾する。",
      ]),
      paragraph([
        "(b) ",
        math(String.raw`y^2>x`),
        " と仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
y^2>x\ \land\ x>0
&\Longrightarrow y^2>0
&&(\because\ \mathbb{R}\ \text{の順序の推移律})\\
&\Longrightarrow y>0
&&(\because\ y\ge0\ \text{と正実数の二乗の単射性})
\end{aligned}`),
      paragraph([
          math(String.raw`\delta:=\dfrac{y^2-x}{2y}\in\mathbb{R}_{>0}`),
          " とおくと ",
          math(String.raw`\delta>0`),
          " である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta
&= \frac{y^2-x}{2y}
&&(\because\ \delta\ \text{の定め方})\\
&< \frac{y^2}{2y}
&&(\because\ y^2-x<y^2\ \text{と}\ 2y>0)\\
&= \frac{y}{2}
&&(\because\ y\ne0\ \text{による約分})\\
&< y
&&(\because\ y>0)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`y-\delta\in\mathbb{R}_{>0}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y-\delta)^2
&= y^2-2y\delta+\delta^2
&&(\because\ \text{分配律})\\
&\ge y^2-2y\delta
&&(\because\ \delta^2\ge 0)\\
&= y^2-2y\cdot\frac{y^2-x}{2y}
&&(\because\ \delta\ \text{の定め方})\\
&= y^2-(y^2-x)
&&(\because\ 2y\ne0\ \text{による約分})\\
&= x
&&(\because\ \mathbb{R}\ \text{の加法の結合性と逆元})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`s\in S`),
        " すなわち ",
        math(String.raw`s\ge 0,\ s^2\le x`),
        " ならば ",
        math(String.raw`s^2\le x\le(y-\delta)^2`),
        " であり、",
        math(String.raw`s\ge 0`),
        " かつ ",
        math(String.raw`y-\delta>0`),
        " なので ",
        math(String.raw`s>y-\delta`),
        " と仮定すると ",
        math(String.raw`s^2>(y-\delta)^2`),
        "（正の数どうしの乗法の単調性）となって矛盾する。よって ",
        math(String.raw`s\le y-\delta`),
        " が全ての ",
        math(String.raw`s\in S`),
        " について成り立ち、",
        math(String.raw`y-\delta`),
        " は ",
        math(String.raw`S`),
        " の上界である。しかし ",
        math(String.raw`y-\delta<y=\sup S`),
        " であり、",
        math(String.raw`\sup S`),
        " が最小の上界であることに矛盾する。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`y^2=x`),
        " であり、",
        math(String.raw`y\in\mathbb{R}_{\ge 0}`),
        " なので存在が示された。一意性と合わせて主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）の非負実数の平方根の定義（labels: definition_of_sqrt_r_positive）は" +
          "存在と一意性を「証明略」としていたが、これは定義が well-defined であるために" +
          "必要な事実なので、独立した claim として切り出して証明した。" +
          "存在は R の上限性質（完備性）を使い、一意性は" +
          "labels: cosh_sinh_basic_properties の (4) を使う。" +
          "非可算集合 R の完備性へ移行する箇所を proof の冒頭で明示した。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 主張の二乗 y^2 を def_power_of_real_number の冪（m = 2）と明記した（definition_of_sqrt_r_positive と同じ）。証明の中で積 s·s・ε·ε へ開く 2 行の名前だけの根拠「2 乗の定義」を、square_of_real_number_is_product（r → s、r → ε）の参照にした（square_of_real_number_is_product は def_power_of_real_number だけから示され平方根を使わないので循環しない。どちらも文書の並びでは後に来る）。",
      ],
    },
  },
  {
    id: "calc_formulae_001_sqrt_nonnegative_real",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/001_definition_非負実数のsqrt.typ", ordinal: 2 },
    title: { tex: "\\sqrt{\\cdot}" },
    labels: ["definition_of_sqrt_r_positive"],
    statement: [
      paragraph([
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}:\mathbb{R}_{\ge 0}\to\mathbb{R}_{\ge 0}`),
        " を次で定める。",
      ]),
      displayMath("x\\in\\mathbb{R}_{\\ge 0}"),
      paragraph(["について、", math("y\\in\\mathbb{R}_{\\ge 0}"), " で"]),
      displayMath("y\\ge 0\\land y^2=x"),
      paragraph([
        "を満たすものがただ一つ存在する（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。二乗 ",
        math(String.raw`y^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。",
      ]),
      paragraph(["この ", math("y"), " を用いて"]),
      displayMath(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})}:=y`),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 二乗 y^2 が def_power_of_real_number の冪か積 yy かを定義の中に書いていなかったので、冪（m = 2）と明記した。積の形が要る行は square_of_real_number_is_product を引く。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（square_of_real_number_is_product と同じ扱い。def_power_of_real_number は平方根を使わないので循環しない）。",
      ],
    },
  },
  {
    id: "calc_formulae_002_negative_number_to_sqrt",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/002_theorem_負数からsqrtへの変換.typ", ordinal: 3 },
    title: { tex: "\\text{負数 }\\to\\sqrt{\\cdot}" },
    labels: ["negative_number_to_sqrt"],
    statement: [
      displayMath("x\\in\\mathbb{R}_{<0}"),
      displayMath(String.raw`x=-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
    ],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`-x`),
        " が平方根の定義の条件を満たすことを見る。",
      ]),
      displayMath(String.raw`\begin{aligned}
-x
&>-0
&&(\because\ x<0\ \text{と加法の逆元による順序の反転})\\
&=0
&&(\because\ 0\ \text{の加法の逆元は}\ 0)
\end{aligned}`),
      paragraph([
        "であり、とくに ",
        math(String.raw`-x\in\mathbb{R}_{\ge 0}`),
        " である。また、",
        ref("real_square_is_nonnegative"),
        "（",
        math(String.raw`r\to -x`),
        "）から ",
        math(String.raw`(-x)^2\in\mathbb{R}_{\ge 0}`),
        " である。したがって ",
        math(String.raw`y=-x`),
        " は条件 ",
        math(String.raw`y\in\mathbb{R}_{\ge 0}\ \land\ y^2=(-x)^2`),
        " を満たす。この条件を満たす ",
        math(String.raw`y`),
        " はただ一つであり（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）、それが ",
        math(String.raw`\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
        " である（",
        ref("definition_of_sqrt_r_positive"),
        "）。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
&=-x
&&(\because\ \text{平方根の定義 }\blkref{definition_of_sqrt_r_positive}
\text{ と条件を満たす元の一意性 }\blkref{sqrt_nonnegative_existence_uniqueness})
\end{aligned}`),
      paragraph([
        "である。以上を使って主張を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
&=-(-x)
&&(\because\ \text{準備で得た等式})\\
&=x
&&(\because\ \text{加法の逆元の逆元はもとの元})
\end{aligned}`),
      paragraph([
        "すなわち ",
        math(String.raw`x=-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-28（Lean の点検の直し、行「ℝ の数・順序・差・商」の順序の (a)）: 名前だけで引いていた「実数の平方は非負」を主張 real_square_is_nonnegative の参照にした（r → −x）。",
        "原文（Typst）の証明は等号でつながった式変形ではなく、" +
          "「-√a = x になるような a」「自乗して a になる実数のうち…」という探索の過程を" +
          "数式の中の日本語として並べたものだった。どの行がどの行から従うのかが書かれておらず、" +
          "そのままでは一ステップ一定理の形に写せない。" +
          "原文が辿っていた筋（-x が平方根の条件を満たすことを見て、一意性から √((-x)^2) = -x を" +
          "出し、両辺の符号を反転する）をそのまま保ったうえで、" +
          "一続きの式変形と行末の根拠へ書き換えた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_index_set_from_one_to_n",
    kind: "definition",
    title: { text: "添字の集合" },
    labels: ["def_index_set_from_one_to_n"],
    lean: ["Ising2D.finIndexToZZ", "Ising2D.finIndexToZZ_bijective_onto_index_set", "Ising2D.finIndexToZZ_lt_iff_val_lt", "Ising2D.finIndexToZZ_eq_iff_val_add_one_eq", "Ising2D.finIndexToZZ_le_inclusion_iff_val_lt", "Ising2D.finIndexToZZ_eq_inclusion_add_one_iff_val_eq", "Ising2D.finIndexToZZ_firstSite", "Ising2D.finIndexToZZ_lastSite", "Ising2D.finIndexToZZ_castLE"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について、",
        math(String.raw`\mathbf{Z}`),
        " の部分集合",
      ]),
      displayMath(String.raw`\{1,\dots,n\} := \{k \in \mathbb{Z}_{\geq 1} \mid k \le_{\mathbb{Z}} n\}`),
      paragraph([
        "を添字の集合と呼ぶ（",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の記号）。行列の成分の添字の集合などに使う（本文には 0 から始まる添字の集合 ",
        math(String.raw`\{0,\dots,N\}`),
        " や二値の集合 ",
        math(String.raw`\{0,1\}`),
        " もあり、それらはこの集合ではない）。",
        math(String.raw`\{1,2\}`),
        "・",
        math(String.raw`\{1,2,3,4\}`),
        " は、それぞれ ",
        math(String.raw`n = 2`),
        "・",
        math(String.raw`n = 4`),
        " のときのこの集合を元を並べて書いたものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-24（Lean の点検の直し、未定義の記号の行「添字の集合 {1,…,n} と Lean の Fin n の間の写像」の一単位目）: 原文（Typst）に対応ブロックは無い。本文は行列の成分・有限和・サイトの添字を {1,…,n} の元として書いていたが、その集合を定めるブロックが無かった。Lean の具体版は添字に Fin n を使い、名前を付けた写像 Ising2D.finIndexToZZ（i ↦ ι_{ℕ→ℤ}(i.val) + 1_ℤ）がこの集合への全単射であることを補題一本 Ising2D.finIndexToZZ_bijective_onto_index_set で示す（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionIndexSetFromOneToN.lean）。写像の行き先を ℕ ではなく ℤ にしたのは、本文の添字の集合が 𝐙 の部分集合だからである。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の四単位目）: 本文は m ≤ n のとき {1,…,m} の元をそのまま {1,…,n} の元として書く（開鎖項 D_0・開鎖のエネルギー E(s)・H_1^{(+)} の和の添字 m ∈ {1,…,M_col−1} をサイトの添字に使う）。Lean の具体版はこの和を Fin (M − 1) の上に取り、サイトへは mathlib の Fin.castLE で移すので、移しても人手の添字が変わらないこと（finIndexToZZ n (Fin.castLE h j) = finIndexToZZ m j）を示す補題 Ising2D.finIndexToZZ_castLE を欄 lean に足した。本文は変えていない。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_complex_matrices",
    kind: "definition",
    title: { text: "複素数を成分とする行列の全体" },
    labels: ["def_complex_matrices"],
    lean: ["Ising2D.matrix_fin_complex_entries_determine_and_realize", "Ising2D.tensorPow_entries_by_kronecker_numbering"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とする。添字の集合の直積 ",
        math(String.raw`\{1,\dots,m\} \times \{1,\dots,n\}`),
        "（",
        ref("def_index_set_from_one_to_n"),
        "）から ",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " への写像の全体を ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " と書き、その元を ",
        math(String.raw`m`),
        " 行 ",
        math(String.raw`n`),
        " 列の複素行列と呼ぶ。",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の ",
        math(String.raw`(i,k) \in \{1,\dots,m\} \times \{1,\dots,n\}`),
        " での値を ",
        math(String.raw`A_{ik} \in \mathbb{C}`),
        " と書き、",
        math(String.raw`A`),
        " の ",
        math(String.raw`(i,k)`),
        " 成分と呼ぶ。",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C}) := \mathrm{Mat}(n,n,\mathbb{C})`),
        " とおく。",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の等号は写像の等号（",
        ref("set_and_algebra_notation"),
        " の「写像の等号は全ての点での値の等号」）であり、成分で書けば",
      ]),
      displayMath(String.raw`A=B\ \Leftrightarrow\ \bigl(\forall i\in\{1,\dots,m\},\ \forall k\in\{1,\dots,n\},\ A_{ik}=B_{ik}\bigr)
\qquad \text{（行列の等号は成分ごとの等号）}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の二単位目）: 原文（Typst）に対応ブロックは無い。Mat(m,n,ℂ) は mat_mult の主張の括弧の中で「成分が複素数である m 行 n 列の行列全体」として積の定義と一緒に置かれていた（1 ブロック 1 主張に反する）ので、定義のブロックとして切り出し、添字の集合の直積から ℂ への写像の全体として定めた。set_and_algebra_notation が外から持ち込む規則として Mat(m,n,ℂ) の定義より前に置いていた「行列の等号は成分ごとの等号」は、行列が写像なので写像の等号の規則の場合であり、ここへ移した。Lean の具体版は mathlib の Matrix (Fin m) (Fin n) ℂ（Fin m → Fin n → ℂ）で、名前を付けた写像 finIndexToZZ を通して成分が行列を定めることと、どの成分の割り当ても行列になることを補題一本 Ising2D.matrix_fin_complex_entries_determine_and_realize で示す。添字を多重添字の集合 𝓘_M に取る Lean の Matrix (Conf M) (Conf M) ℂ（本文の Mat(2^M,ℂ)）は、ν^{-1} で番号へ移した成分が行列を定めることと、どの成分の割り当ても行列になることを Ising2D.tensorPow_entries_by_kronecker_numbering で示す（MathematicalTools/KroneckerProductAndMultiFactorBasis/DefinitionMatrixOperationsOverMultiIndices.lean）。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_complex_number_vectors",
    kind: "definition",
    title: { text: "複素数を成分とする数ベクトルの全体" },
    labels: ["def_complex_number_vectors"],
    lean: ["Ising2D.vecToColumn", "Ising2D.confVec_eq_iff_entries_by_kronecker_numbering"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`\mathbb{C}^n := \mathrm{Mat}(n,1,\mathbb{C})`),
        "（",
        ref("def_complex_matrices"),
        " の記号）と定め、その元を数ベクトルと呼ぶ。",
        math(String.raw`a \in \mathbb{C}^n`),
        " と ",
        math(String.raw`j \in \{1,\dots,n\}`),
        " について、",
        math(String.raw`a`),
        " の ",
        math(String.raw`(j,1)`),
        " 成分を ",
        math(String.raw`a_j := a_{j1} \in \mathbb{C}`),
        " と書き、",
        math(String.raw`a`),
        " の第 ",
        math(String.raw`j`),
        " 成分と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の三単位目）: 原文（Typst）に対応ブロックは無い。mat_mult の主張の最後の文が「数ベクトル a ∈ ℂ^n は n 行 1 列の行列とみなし」と、名前を付けた写像を通さない同一視で数ベクトルを扱っていた。本文は部分空間 def_subspace・核・固有空間・標準基底 e_t := E^{(m,1)}_{t1} などで ℂ^n を n 行 1 列の行列の全体として使っているので、同一視ではなく定義 ℂ^n := Mat(n,1,ℂ) として立てた。成分の略記 a_j := a_{j1} もここで定める。Lean の具体版は数ベクトルを第 j 成分の割り当て Fin n → ℂ で持ち、それを n 行 1 列の行列へ送る写像 Ising2D.vecToColumn（(vecToColumn v)_{j1} := v_j）に名前を付けた（MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean）。",
      ],
    },
  },
  {
    id: "calc_formulae_003_matrix_decomposition",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/003_theorem_行列の分解.typ", ordinal: 4 },
    title: { text: "行列の積の成分による定義" },
    labels: ["mat_mult"],
    lean: ["Ising2D.matrix_mul_apply_sum", "Ising2D.mulVec_apply_sum", "Ising2D.mul_two_apply", "Ising2D.mulVec_two_zero", "Ising2D.mulVec_two_one", "Ising2D.tensorPow_mul_apply_eq_mat_mult", "Ising2D.matrix_conf_mul_apply_eq_mat_mult", "Ising2D.tensorPow_mul_apply", "Ising2D.matrix_conf_mul_tensorPow_apply_eq_mat_mult", "Ising2D.tensorPow_mul_matrix_conf_apply_eq_mat_mult", "Ising2D.matrix_conf_mul_tensorPow_apply", "Ising2D.tensorPow_mul_matrix_conf_apply", "Ising2D.tensorPow_mulVec_apply_eq_mat_mult", "Ising2D.tensorPow_mulVec_apply"],
    statement: [
      paragraph([
        math(String.raw`m,n,p \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする（",
        ref("def_complex_matrices"),
        " の記号）。積 ",
        math(String.raw`AB \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`(AB)_{ik} := \sum_{j=1}^{n} A_{ij}\,B_{jk}
\qquad (i \in \{1,\dots,m\},\ k \in \{1,\dots,p\})`),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`n`),
        " 個の複素数の有限和（",
        ref("def_finite_sum_of_complex_numbers"),
        "）である。数ベクトル ",
        math(String.raw`a \in \mathbb{C}^n`),
        "（",
        ref("def_complex_number_vectors"),
        "）は ",
        math(String.raw`\mathrm{Mat}(n,1,\mathbb{C})`),
        " の元なので、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " と ",
        math(String.raw`a`),
        " の積 ",
        math(String.raw`Aa \in \mathbb{C}^m`),
        " はこの定義の ",
        math(String.raw`p = 1`),
        " の場合である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05: 原文のこのブロックは Typst の行列構成子 mat(...) を使った「行列の分解」で、記号 mat が本文で定義されておらず証明も無かった。一方このラベル mat_mult は本文の20箇所以上から「行列の積の定義」として引かれていた。引用の意味と一致するよう、成分による積の定義そのものをこのラベルの内容とした。原文が述べていた列ごとの作用は次のブロックへ、記法を定義したうえで移した。",
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の二単位目）: 主張の括弧の中にあった Mat(m,n,ℂ) の定め（成分が複素数である m 行 n 列の行列全体、Mat(n,ℂ) := Mat(n,n,ℂ)）を定義のブロック def_complex_matrices へ切り出し、ここはその参照にした。欄 lean に、Lean の TensorPow M（添字が 𝓘_M の行列）の積の成分を ν^{-1} で番号へ移すとこの定義の右辺に等しいことを述べる補題 Ising2D.tensorPow_mul_apply_eq_mat_mult と、そこから導く 𝓘_M の添字の形 Ising2D.tensorPow_mul_apply を足した。",
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の三単位目）: 主張の最後の文「数ベクトル a ∈ ℂ^n は n 行 1 列の行列とみなし、Aa も同じ式で定める」は、名前を付けた写像を通さない同一視だったので、ℂ^n := Mat(n,1,ℂ) を定義のブロック def_complex_number_vectors として立て、Aa はこの定義の p = 1 の場合であると書き直した。式は不変。欄 lean に、Lean の TensorPow M（添字が 𝓘_M の行列）と数ベクトルの積の成分を ν^{-1} で番号へ移すとこの定義の p = 1 の右辺に等しいことを述べる補題 Ising2D.tensorPow_mulVec_apply_eq_mat_mult と、そこから導く 𝓘_M の添字の形 Ising2D.tensorPow_mulVec_apply を足した。",
      ],
    },
  },
  {
    id: "calc_formulae_004_action_on_matrix_pair",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/004_theorem_行列の組みへの作用.typ", ordinal: 5 },
    title: { text: "行列の積は列ごとに作用する" },
    labels: ["mat_columnwise"],
    lean: ["Ising2D.matrix_mul_columns", "Ising2D.mul_columns_tensorPow"],
    statement: [
      paragraph([
        math(String.raw`m,n,p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`b_1,\dots,b_p \in \mathbb{C}^n`),
        " とし、これらを列に並べた行列を ",
        math(String.raw`\left[\,b_1\ \cdots\ b_p\,\right] \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " と書く（第 ",
        math(String.raw`k`),
        " 列の第 ",
        math(String.raw`j`),
        " 成分が ",
        math(String.raw`(b_k)_j`),
        " である行列）。このとき",
      ]),
      displayMath(String.raw`A\left[\,b_1\ \cdots\ b_p\,\right]
= \left[\,Ab_1\ \cdots\ Ab_p\,\right]`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺は同じ大きさの行列なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(A\left[\,b_1\ \cdots\ b_p\,\right]\right)_{ik}
&=\sum_{j=1}^{n} A_{ij}\,\left(\left[\,b_1\ \cdots\ b_p\,\right]\right)_{jk}
  &&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&=\sum_{j=1}^{n} A_{ij}\,(b_k)_j
  &&\bigl(\because\ \text{列に並べた行列の成分の定め方}\bigr)\\
&=(Ab_k)_i
  &&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\ \text{の}\ p=1\ \text{を}\ Ab_k\ \text{へ適用し、成分を}\ \blkref{def_complex_number_vectors}\ \text{の略記で書く}\bigr)\\
&=\left(\left[\,Ab_1\ \cdots\ Ab_p\,\right]\right)_{ik}
  &&\bigl(\because\ \text{列に並べた行列の成分の定め方}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05: 原文は Typst の行列構成子 mat(...) で「mat(Aa,Ab)=A mat(a,b)」と書いていたが、その記号は本文で定義されておらず証明も無かった。列に並べた行列という記法を主張の中で定義し、成分計算の四段で証明した。",
        "2026-11-26（Lean の点検の直し、状態台帳の行「行列とその演算」の三単位目）: 3 行目の根拠に、mat_mult の p = 1 の場合であることと、数ベクトルの成分の略記 (b_k)_j := (b_k)_{j1} を定める def_complex_number_vectors を書き足した。式は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_005_matrix_conjugation",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/005_theorem_行列の共役.typ", ordinal: 6 },
    title: { text: "行列の共役" },
    labels: ["mat_conj"],
    lean: ["Ising2D.conj_add_matrix", "Ising2D.conj_smul_matrix", "Ising2D.conj_add_tensorPow", "Ising2D.conj_smul_tensorPow"],
    statement: [
      paragraph([
        math("n\\in\\mathbb{Z}_{\\geq 1}"),
        "、",
        math("A,B\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        "、",
        math("B"),
        " は正則とする。",
      ]),
      paragraph([
        math("\\operatorname{Mat}(n,\\mathbb{C})"),
        " の各元 ",
        math("A"),
        " に対して ",
        math("T_B(A):=BAB^{-1} \\in \\operatorname{Mat}(n,\\mathbb{C})"),
        " と定める（",
        math("BAB^{-1}"),
        " は ",
        math("(BA)B^{-1}"),
        " と読む）。このとき ",
        math("T_B"),
        " は和とスカラー倍を保つ。すなわち",
      ]),
      displayMath(String.raw`T_B(A+C)=T_B(A)+T_B(C),\qquad
T_B(\alpha A)=\alpha\,T_B(A)
\qquad (A,C\in\operatorname{Mat}(n,\mathbb{C}),\ \alpha\in\mathbb{C})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "和を保つことと、スカラー倍を保つことを別々に示す。鎖が引く 4 つの主張（行列の積の分配の 2 つと、スカラー倍を積の外へ出す 2 つ）は、どれもその ",
        math("m, n, p"),
        " をすべてこの主張の ",
        math("n"),
        " として使う。",
      ]),
      paragraph([
        "第一に、和を保つこと。",
        math("A,C\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(A+C)
&=\bigl(B(A+C)\bigr)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=(BA+BC)B^{-1}
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor})\\
&=(BA)B^{-1}+(BC)B^{-1}
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor})\\
&=T_B(A)+T_B(C)
&&(\because\ T_B\ \text{の定義を 2 か所へ同時適用})
\end{aligned}`),
      paragraph([
        "である。第二に、スカラー倍を保つこと。",
        math("A\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        " と ",
        math("\\alpha\\in\\mathbb{C}"),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(\alpha A)
&=\bigl(B(\alpha A)\bigr)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=\bigl(\alpha(BA)\bigr)B^{-1}
&&(\because\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&=\alpha\bigl((BA)B^{-1}\bigr)
&&(\because\ \blkref{scalar_multiple_factors_out_of_left_factor})\\
&=\alpha\,T_B(A)
&&(\because\ T_B\ \text{の定義})
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math("T_B"),
        " は和とスカラー倍を保つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-02: 和の鎖の「行列の積の左からの分配則」「右からの分配則」と、スカラー倍の鎖の「スカラー倍と行列の積の交換」2 か所の名前だけの根拠を、" +
          "mat_mult_distributes_over_sum_in_right_factor・mat_mult_distributes_over_sum_in_left_factor・scalar_multiple_factors_out_of_right_factor・scalar_multiple_factors_out_of_left_factor へのラベル参照にした。" +
          "BAB^{-1} を (BA)B^{-1} と読むことと n ∈ ℤ_{≥1} を主張に書き、鎖の積に括弧を全て書いた。主張の中身は変えていない。" +
          "有限和を保つことは、別の主張 matrix_conjugation_preserves_finite_sum として足した。" +
          "Lean の対応は Ising2D.conj_add_matrix・Ising2D.conj_smul_matrix（同じ行の calc）。数値検証: sagemath/check/122_mat_conj/check_02_chains.sage。",
        "原文（Typst）の証明は等号でつなげてはあったが、各行の根拠が書かれておらず、" +
          "スカラー倍の側では B(αA)B^{-1} = α(BAB^{-1}) が 1 行に詰められていた" +
          "（スカラー倍と行列の積の交換を 2 度使っている）。" +
          "行末の (∵ …) を付け、詰まっていた行を 2 段へ分けた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_finite_sum",
    kind: "claim",
    title: { text: "行列の共役は有限和を保つ" },
    labels: ["matrix_conjugation_preserves_finite_sum"],
    lean: ["Ising2D.conj_finite_sum_of_matrices"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`X_1,\dots,X_r \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、有限和は ",
        ref("def_finite_sum_of_matrices"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B\Bigl(\sum_{j=1}^{r} X_j\Bigr) = \sum_{j=1}^{r} T_B(X_j)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math("r"), " についての帰納法で示す。", math("r = 1"), " のとき"]),
      displayMath(String.raw`\begin{aligned}
T_B\Bigl(\sum_{j=1}^{1} X_j\Bigr)
&= T_B(X_1)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} T_B(X_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 }T_B(X_j)\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math("r"),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \operatorname{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)
&= T_B\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= T_B\Bigl(\sum_{j=1}^{r} X_j\Bigr) + T_B(X_{r+1})
&&\bigl(\because\ \blkref{mat_conj}\ \text{の和を保つこと}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} T_B(X_j)\Bigr) + T_B(X_{r+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} T_B(X_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 }T_B(X_j)\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の「共役の ℂ 線型性」を H_1^{(+)}・H_2 の有限和へ適用する段を引けるよう足した。" +
          "Lean の対応は Ising2D.conj_finite_sum_of_matrices（同じ帰納法の calc）。数値検証: sagemath/check/matrix_conjugation_preserves_finite_sum/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_negation",
    kind: "claim",
    title: { text: "行列の共役は符号反転を保つ" },
    labels: ["matrix_conjugation_preserves_negation"],
    lean: ["Ising2D.conj_neg_matrix", "Ising2D.conj_neg_tensorPow"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`W \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B(-W) = -\,T_B(W)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "鎖が引く 2 つの主張（符号反転を積の外へ出す 2 つ）は、どちらもその ",
        math("m, n, p"),
        " をすべてこの主張の ",
        math("n"),
        " として使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(-W)
&=\bigl(B(-W)\bigr)B^{-1}
&&(\because\ \blkref{mat_conj}\ \text{の}\ T_B\ \text{の定義})\\
&=\bigl(-(BW)\bigr)B^{-1}
&&(\because\ \blkref{negation_factors_out_of_right_factor})\\
&=-\bigl((BW)B^{-1}\bigr)
&&(\because\ \blkref{negation_factors_out_of_left_factor})\\
&=-\,T_B(W)
&&(\because\ \blkref{mat_conj}\ \text{の}\ T_B\ \text{の定義})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の H_1^{(+)} の鎖で、差の項 Y_{M_col}Z_1 の共役を扱う段（matrix_conjugation_preserves_difference）に要るので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_difference",
    kind: "claim",
    title: { text: "行列の共役は差を保つ" },
    labels: ["matrix_conjugation_preserves_difference"],
    lean: ["Ising2D.conj_sub_matrix", "Ising2D.conj_sub_tensorPow"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`X, W \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、差は ",
        ref("def_matrix_difference"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B(X - W) = T_B(X) - T_B(W)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
T_B(X - W)
&= T_B\bigl(X + (-W)\bigr)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to X,\ B \to W)\bigr)\\
&= T_B(X) + T_B(-W)
&&\bigl(\because\ \blkref{mat_conj}\ \text{の和を保つこと}\ (A \to X,\ C \to -W)\bigr)\\
&= T_B(X) + \bigl(-\,T_B(W)\bigr)
&&\bigl(\because\ \blkref{matrix_conjugation_preserves_negation}\bigr)\\
&= T_B(X) - T_B(W)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to T_B(X),\ B \to T_B(W))\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の H_1^{(+)} = Σ_{m=1}^{M_col−1} Y_mZ_{m+1} − Y_{M_col}Z_1 の共役を、和の項と差の項に割る段を引けるよう足した。",
      ],
    },
  },
  {
    id: "calc_formulae_006_definition_of_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/006_definition_CCの定義.typ", ordinal: 7 },
    title: { tex: "\\mathbb{C}\\text{の定義}" },
    labels: ["definition_of_cc"],
    lean: ["Ising2D.complex_mk_eq_mk_iff", "Ising2D.complex_mk_add_mk", "Ising2D.complex_mk_mul_mk"],
    statement: [
      paragraph([ref("set_and_algebra_notation"), " の実数の台集合と演算を使う。"]),
      paragraph([math(String.raw`\mathbf{C}:=\mathbf{R}^2`), " を複素数の台集合とし、その上に以下の演算を入れた構造を ", math(String.raw`\mathbb C`), " と書く。"]),
      paragraph(["和（成分ごと）"]),
      displayMath(String.raw`+_{\mathbb C}:\mathbf C\times\mathbf C\to\mathbf C,\qquad(a,b)+_{\mathbb C}(c,d):=(a+_{\mathbb R}c,\ b+_{\mathbb R}d)`),
      paragraph(["積"]),
      displayMath(String.raw`\cdot_{\mathbb C}:\mathbf C\times\mathbf C\to\mathbf C,\qquad(a,b)\cdot_{\mathbb C}(c,d):=(a\cdot_{\mathbb R}c-b\cdot_{\mathbb R}d,\ a\cdot_{\mathbb R}d+b\cdot_{\mathbb R}c)`),
      paragraph([
        "本論文で ",
        math("\\mathbb{C}"),
        " に必要な構造はこの2つの演算だけである。和は指数関数の級数（",
        ref("matrix_exp_series_converges"),
        "）と絶対値の三角不等式（",
        ref("abs_basic_properties"),
        "）で必要になる。",
      ]),
    ],
  },
  {
    id: "calc_formulae_definition_imaginary_unit",
    kind: "definition",
    title: { tex: String.raw`\text{虚数単位}` },
    labels: ["def_imaginary_unit"],
    lean: ["Ising2D.complex_I_eq_mk"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " の実数の零元 ",
        math(String.raw`0_{\mathbb{R}}`),
        " と単位元 ",
        math(String.raw`1_{\mathbb{R}}`),
        " を使い、",
        ref("definition_of_cc"),
        " の元",
      ]),
      displayMath(String.raw`i := (0_{\mathbb{R}}, 1_{\mathbb{R}}) \in \mathbb{C}`),
      paragraph(["を虚数単位と呼ぶ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。虚数単位を定めるブロックが計算公式の章に無く、antiperiodic_exp_sum ほかの主張の前置きが各自で i := (0,1) を置き、conjugate_transpose_of_pauli_y などの前の章の証明が後ろの章の antiperiodic_exp_sum の前置きを根拠に引いていたので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_007_inclusion_rr_to_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/007_definition_RRからCCへの包含写像.typ", ordinal: 8 },
    title: { tex: "\\mathbb{R}\\to\\mathbb{C}\\text{の包含写像}" },
    labels: ["inclusion_rr_to_cc"],
    lean: ["Ising2D.complex_ofReal_eq_mk", "Ising2D.complex_zero_eq_ofReal_zero", "Ising2D.complex_one_eq_ofReal_one", "Ising2D.complex_two_eq_ofReal_two"],
    statement: [
      paragraph([math("\\iota_{\\mathbb{R}\\to\\mathbb{C}}:\\mathbb{R}\\to\\mathbb{C}"), " を"]),
      displayMath("\\iota_{\\mathbb{R}\\to\\mathbb{C}}(x):=(x,0)"),
      paragraph(["として定める。これを ", math("\\mathbb{R}"), " から ", math("\\mathbb{C}"), " への包含写像と呼ぶ。"]),
      paragraph(["略記として、", math("r\\in\\mathbb{R}"), " について"]),
      displayMath("r_{\\mathbb{C}}:=\\iota_{\\mathbb{R}\\to\\mathbb{C}}(r)"),
      paragraph([
        "と書く。とくに ",
        ref("set_and_algebra_notation"),
        " の実数の零元 ",
        math(String.raw`0_{\mathbb{R}}`),
        " と単位元 ",
        math(String.raw`1_{\mathbb{R}}`),
        " の像を",
      ]),
      displayMath(String.raw`0_{\mathbb{C}} := (0_{\mathbb{R}})_{\mathbb{C}},\qquad 1_{\mathbb{C}} := (1_{\mathbb{R}})_{\mathbb{C}}`),
      paragraph(["と書き、", ref("def_real_two"), " の ", math(String.raw`2 \in \mathbb{R}`), "（以下 ", math(String.raw`2_{\mathbb{R}}`), " と書く）の像を"]),
      displayMath(String.raw`2_{\mathbb{C}} := (2_{\mathbb{R}})_{\mathbb{C}}`),
      paragraph(["と書く。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-22（Lean の点検の直し）: 本文は 0_ℂ・1_ℂ を略記 r_ℂ の r = 0・r = 1 として使っていたが、そう書いたブロックが無かったので、略記の特別な場合として 0_ℂ := (0_ℝ)_ℂ・1_ℂ := (1_ℝ)_ℂ を書き足した。定義の中身は変えていない。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℂ とその演算」のうち ℂ の数 2）: 本文は 2_ℂ := (2_ℝ)_ℂ を 8 か所の証明・主張でその場で定めていたので、略記の特別な場合として 2_ℂ := (2_ℝ)_ℂ を書き足し、その 8 か所を := から = にした（どれも既に inclusion_rr_to_cc を引いている）。Lean の具体版は Ising2D.complex_two_eq_ofReal_two（mathlib の ℂ の数字 2 は Nat.cast 2 を通すので、Complex.ofReal_ofNat との一致の補題一本）。定義の中身は変えていない。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_rr_to_cc_is_injective",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{R}\to\mathbb{C}}\ \text{は単射}` },
    labels: ["inclusion_rr_to_cc_is_injective"],
    lean: ["Ising2D.inclusion_rr_to_cc_is_injective"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " が ",
        math(String.raw`a_{\mathbb{C}} = b_{\mathbb{C}}`),
        " を満たすなら ",
        math(String.raw`a = b`),
        " である。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(a, 0)
&= a_{\mathbb{C}}
  &&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ (x \to a)\bigr)\\
&= b_{\mathbb{C}}
  &&\bigl(\because\ \text{仮定}\bigr)\\
&= (b, 0)
  &&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ (x \to b)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbf{C} = \mathbf{R}^2`),
        "（",
        ref("definition_of_cc"),
        "）の二つの元が等しいのは第 1 成分どうしと第 2 成分どうしがそれぞれ等しいときなので、第 1 成分を比べて ",
        math(String.raw`a = b`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。成分がすべて実数の複素行列から実数の行列を定める def_real_matrix_of_real_entry_matrix が、各成分の実数がただ一つに決まることに使うので足した（ε の固有値 +1 の固有空間の上限の章の証明は、同じ事実を「(·)_ℂ の単射性」と呼んで証明の中で示している）。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_inclusion_nn_to_zz",
    kind: "definition",
    title: { tex: String.raw`\mathbb{N}\to\mathbb{Z}\text{の包含写像}` },
    labels: ["inclusion_nn_to_zz"],
    lean: ["Ising2D.inclusionNNtoZZ", "Ising2D.inclusionNNtoZZ_eq_natCast", "Ising2D.inclusionNNtoZZ_exists_preimage_of_nonneg"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " は ",
        math(String.raw`\mathbb{N}`),
        " と ",
        math(String.raw`\mathbb{Z}`),
        " を別々の台集合の上の構造として置く。写像 ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}:\mathbb{N}\to\mathbb{Z}`),
        " を、",
        math(String.raw`n \in \mathbf{N}`),
        " についての帰納法（",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{N}`),
        " の再帰による定義。",
        math(String.raw`X \to \mathbf{Z}`),
        "、",
        math(String.raw`a \to 0_{\mathbb{Z}}`),
        "、",
        math(String.raw`f(n, z) \to z +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        "）で",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}(0_{\mathbb{N}}) := 0_{\mathbb{Z}},
\qquad
\iota_{\mathbb{N}\to\mathbb{Z}}(n +_{\mathbb{N}} 1_{\mathbb{N}}) := \iota_{\mathbb{N}\to\mathbb{Z}}(n) +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
      paragraph([
        "と定める（再帰による定義により、この二つの式を満たす写像はただ一つである）。これを ",
        math(String.raw`\mathbb{N}`),
        " から ",
        math(String.raw`\mathbb{Z}`),
        " への包含写像と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の先頭）: 原文（Typst）に対応ブロックは無い。ι_{ℕ→ℤ} は antiperiodic_exp_sum の主張の前置きで「零、単位元、和、積、順序を保つものとする」と置かれているだけで、写像そのものを定めるブロックが無かった。inclusion_zz_to_rr の ℤ_{≥0} の節と同じ形で、その前に置いた。単位元・和・積・順序を保つことの主張は、同じ行の続きで 1 ブロック 1 主張で足す。set_and_algebra_notation に ℕ の再帰による定義（存在と一意性）の宣言を足し、この定義はそれを引く。Lean の具体版は Ising2D.inclusionNNtoZZ（MathematicalTools/SetNotationAndComplexCartesianArithmetic/DefinitionInclusionOfNaturalNumbersIntoIntegers.lean。同じ二つの式を Nat.rec で定める）で、Lean の Nat.cast（ℕ → ℤ）との一致は補題一本 Ising2D.inclusionNNtoZZ_eq_natCast である。",
        "2026-11-24（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の続き）: 欄 lean に Ising2D.inclusionNNtoZZ_exists_preimage_of_nonneg（0_ℤ ≤ a の a ∈ ℤ はある n ∈ ℕ の像 ι_{ℕ→ℤ}(n) である）を足した。本文は ℤ_{≥0} の元を ℤ の元のまま扱うが、Lean の具体版は ℤ_{≥0} の元を ℕ の元の像として書き直す段を持つ（inclusion_zz_to_rr_neg・inclusion_zz_to_rr_of_successor・inclusion_zz_to_rr_of_nonpositive_is_nonpositive・inclusion_zz_to_rr_is_monotone_on_nonnegatives・limit_of_log_Z_in_N_row の具体版）。その Lean だけの段を mathlib の Int.toNat・Int.eq_ofNat_of_zero_le から、名前を付けた写像 ι_{ℕ→ℤ} を通すこの補題へ替えた。いまは本文の主張のブロックではないので本文の証明は無いが、同じ内容（ℤ_{≥0} への全射）を antiperiodic_exp_sum の前置きが証明なしに使っている。antiperiodic_exp_sum の主張の前置きの「(M_col)_ℕ が一意に在る」を引く主張（ℤ_{≥0} への全射と順序の逆向き）は、Lean の antiperiodic_exp_sum の族が初めから M : ℕ を取るため、族の仮定を ℤ の M_col に寄せる回に置き、この補題をそのブロックの欄 lean へ移す。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_nn_to_zz_image_is_nonnegative",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}\text{ の像は } 0_{\mathbb{Z}} \text{ 以上}` },
    labels: ["inclusion_nn_to_zz_image_is_nonnegative"],
    lean: ["Ising2D.inclusion_nn_to_zz_image_is_nonnegative"],
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n \in \mathbf{N}`),
        " について、",
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " は",
      ]),
      displayMath(String.raw`0_{\mathbb{Z}} \le_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(n)`),
      paragraph([
        "を満たす。",
        math(String.raw`0_{\mathbb{Z}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の零元・順序である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathbf{N}`),
        " の元についての命題 ",
        math(String.raw`\varphi(n) :\Leftrightarrow 0_{\mathbb{Z}} \le_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(n)`),
        " に ",
        math(String.raw`\mathbb{N}`),
        " の数学的帰納法（",
        ref("set_and_algebra_notation"),
        "）を使う。以下の二つの鎖の ",
        math(String.raw`\le`),
        " と ",
        math(String.raw`=`),
        " の連なりは ",
        math(String.raw`\mathbb{Z}`),
        " の順序の推移律（",
        ref("set_and_algebra_notation"),
        "）でつなぐ。",
        math(String.raw`n = 0_{\mathbb{N}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&\le 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の順序の反射律}\ x \le x\ (x \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{N}\to\mathbb{Z}}(0_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota_{\mathbb{N}\to\mathbb{Z}}(0_{\mathbb{N}}) := 0_{\mathbb{Z}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n \in \mathbf{N}`),
        " で ",
        math(String.raw`0_{\mathbb{Z}} \le \iota_{\mathbb{N}\to\mathbb{Z}}(n)`),
        " が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{Z}}
&= 0_{\mathbb{Z}} + 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + x = x\ (x \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le 1_{\mathbb{Z}} + 0_{\mathbb{Z}}
&&\bigl(\because\ \blkref{int_zero_at_most_one}\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ x \le y \Rightarrow x + t \le y + t\ (x \to 0_{\mathbb{Z}},\ y \to 1_{\mathbb{Z}},\ t \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}} + 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換律}\ x + y = y + x\ (x \to 1_{\mathbb{Z}},\ y \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&\le \iota_{\mathbb{N}\to\mathbb{Z}}(n) + 1_{\mathbb{Z}}
&&\bigl(\because\ \text{帰納法の仮定}\ 0_{\mathbb{Z}} \le \iota_{\mathbb{N}\to\mathbb{Z}}(n)\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ (x \to 0_{\mathbb{Z}},\ y \to \iota_{\mathbb{N}\to\mathbb{Z}}(n),\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{N}\to\mathbb{Z}}(n +_{\mathbb{N}} 1_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota_{\mathbb{N}\to\mathbb{Z}}(n +_{\mathbb{N}} 1_{\mathbb{N}}) := \iota_{\mathbb{N}\to\mathbb{Z}}(n) +_{\mathbb{Z}} 1_{\mathbb{Z}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`n +_{\mathbb{N}} 1_{\mathbb{N}}`),
        " でも成り立つ。数学的帰納法により、すべての ",
        math(String.raw`n \in \mathbf{N}`),
        " で ",
        math(String.raw`0_{\mathbb{Z}} \le \iota_{\mathbb{N}\to\mathbb{Z}}(n)`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の続き）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の 0_ℤ ≤ M_col の鎖が「ι_{ℕ→ℤ} は順序を保つ」と主張の前置きの仮定を引いていたが、そこで要るのは像が 0_ℤ 以上であることだけなので、その形の主張として足した（順序を保つことは、ほかの引く箇所と同じ回に別の主張で足す）。Lean の具体版は Ising2D.inclusion_nn_to_zz_image_is_nonnegative（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative.lean）、必要十分版は Ising2D.NecSuf.zero_le_of_rec_add_one（NecSuf/ZeroLeOfRecAddOne.lean）。数値検証: sagemath/check/inclusion_nn_to_zz_image_is_nonnegative/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_nn_to_zz_preserves_sum",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}\text{ は和を保つ}` },
    labels: ["inclusion_nn_to_zz_preserves_sum"],
    lean: ["Ising2D.inclusion_nn_to_zz_preserves_sum"],
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`x, y \in \mathbf{N}`),
        " について、",
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " は",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}(x +_{\mathbb{N}} y) = \iota_{\mathbb{N}\to\mathbb{Z}}(x) +_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(y)`),
      paragraph([
        "を満たす。",
        math(String.raw`+_{\mathbb{N}}`),
        "・",
        math(String.raw`+_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{N}`),
        "・",
        math(String.raw`\mathbb{Z}`),
        " の和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x \in \mathbf{N}`),
        " を固定し、",
        math(String.raw`\mathbf{N}`),
        " の元についての命題 ",
        math(String.raw`\varphi(y) :\Leftrightarrow \iota_{\mathbb{N}\to\mathbb{Z}}(x +_{\mathbb{N}} y) = \iota_{\mathbb{N}\to\mathbb{Z}}(x) +_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(y)`),
        " に ",
        math(String.raw`\mathbb{N}`),
        " の数学的帰納法（",
        ref("set_and_algebra_notation"),
        "）を使う。以下では ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " を ",
        math(String.raw`\iota`),
        " と略す。",
        math(String.raw`y = 0_{\mathbb{N}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota(x +_{\mathbb{N}} 0_{\mathbb{N}})
&= \iota(x)
&&\bigl(\because\ \mathbb{N}\ \text{の和の再帰の式}\ x + 0_{\mathbb{N}} = x\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x) +_{\mathbb{Z}} 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ (x \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \iota(x) +_{\mathbb{Z}} \iota(0_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(0_{\mathbb{N}}) := 0_{\mathbb{Z}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`y \in \mathbf{N}`),
        " で ",
        math(String.raw`\varphi(y)`),
        " が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota\bigl(x +_{\mathbb{N}} (y +_{\mathbb{N}} 1_{\mathbb{N}})\bigr)
&= \iota\bigl((x +_{\mathbb{N}} y) +_{\mathbb{N}} 1_{\mathbb{N}}\bigr)
&&\bigl(\because\ \mathbb{N}\ \text{の和の再帰の式}\ x + (y + 1_{\mathbb{N}}) = (x + y) + 1_{\mathbb{N}}\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x +_{\mathbb{N}} y) +_{\mathbb{Z}} 1_{\mathbb{Z}}
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(n +_{\mathbb{N}} 1_{\mathbb{N}}) := \iota(n) +_{\mathbb{Z}} 1_{\mathbb{Z}}\ (n \to x +_{\mathbb{N}} y)\bigr)\\
&= \bigl(\iota(x) +_{\mathbb{Z}} \iota(y)\bigr) +_{\mathbb{Z}} 1_{\mathbb{Z}}
&&\bigl(\because\ \text{帰納法の仮定}\ \varphi(y)\bigr)\\
&= \iota(x) +_{\mathbb{Z}} \bigl(\iota(y) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \iota(x),\ y \to \iota(y),\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x) +_{\mathbb{Z}} \iota(y +_{\mathbb{N}} 1_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(n +_{\mathbb{N}} 1_{\mathbb{N}}) := \iota(n) +_{\mathbb{Z}} 1_{\mathbb{Z}}\ (n \to y)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\varphi(y +_{\mathbb{N}} 1_{\mathbb{N}})`),
        " も成り立つ。数学的帰納法により、すべての ",
        math(String.raw`y \in \mathbf{N}`),
        " で ",
        math(String.raw`\varphi(y)`),
        " である。",
        math(String.raw`x`),
        " は任意だったので、主張が従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の続き）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の主張の前置きが「ι_{ℕ→ℤ} は和を保つ」を仮定として置き、証明が名前だけで引いていた。inclusion_nn_to_zz_preserves_product の証明が使う部品として、inclusion_nn_to_zz の二つの式と set_and_algebra_notation の ℕ・ℤ の行から示す主張として足した。Lean の具体版は Ising2D.inclusion_nn_to_zz_preserves_sum（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum.lean）、必要十分版は Ising2D.NecSuf.map_add_of_rec_add_one（NecSuf/MapAddOfRecAddOne.lean）。数値検証: sagemath/check/inclusion_nn_to_zz_preserves_sum/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_nn_to_zz_preserves_product",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}\text{ は積を保つ}` },
    labels: ["inclusion_nn_to_zz_preserves_product"],
    lean: ["Ising2D.inclusion_nn_to_zz_preserves_product"],
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`x, y \in \mathbf{N}`),
        " について、",
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " は",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}(x \cdot_{\mathbb{N}} y) = \iota_{\mathbb{N}\to\mathbb{Z}}(x) \cdot_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(y)`),
      paragraph([
        "を満たす。",
        math(String.raw`\cdot_{\mathbb{N}}`),
        "・",
        math(String.raw`\cdot_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{N}`),
        "・",
        math(String.raw`\mathbb{Z}`),
        " の積である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x \in \mathbf{N}`),
        " を固定し、",
        math(String.raw`\mathbf{N}`),
        " の元についての命題 ",
        math(String.raw`\varphi(y) :\Leftrightarrow \iota_{\mathbb{N}\to\mathbb{Z}}(x \cdot_{\mathbb{N}} y) = \iota_{\mathbb{N}\to\mathbb{Z}}(x) \cdot_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(y)`),
        " に ",
        math(String.raw`\mathbb{N}`),
        " の数学的帰納法（",
        ref("set_and_algebra_notation"),
        "）を使う。以下では ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " を ",
        math(String.raw`\iota`),
        " と略す。",
        math(String.raw`y = 0_{\mathbb{N}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota(x \cdot_{\mathbb{N}} 0_{\mathbb{N}})
&= \iota(0_{\mathbb{N}})
&&\bigl(\because\ \mathbb{N}\ \text{の積の再帰の式}\ x \cdot 0_{\mathbb{N}} = 0_{\mathbb{N}}\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{Z}}
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(0_{\mathbb{N}}) := 0_{\mathbb{Z}}\bigr)\\
&= 0_{\mathbb{Z}} \cdot_{\mathbb{Z}} \iota(x)
&&\bigl(\because\ \blkref{int_zero_times_is_zero}\ (x \to \iota(x))\ \text{を右辺から左辺へ}\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} 0_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の乗法の交換律}\ x \cdot y = y \cdot x\ (x \to 0_{\mathbb{Z}},\ y \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} \iota(0_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(0_{\mathbb{N}}) := 0_{\mathbb{Z}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`y \in \mathbf{N}`),
        " で ",
        math(String.raw`\varphi(y)`),
        " が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota\bigl(x \cdot_{\mathbb{N}} (y +_{\mathbb{N}} 1_{\mathbb{N}})\bigr)
&= \iota(x \cdot_{\mathbb{N}} y +_{\mathbb{N}} x)
&&\bigl(\because\ \mathbb{N}\ \text{の積の再帰の式}\ x \cdot (y + 1_{\mathbb{N}}) = x \cdot y + x\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x \cdot_{\mathbb{N}} y) +_{\mathbb{Z}} \iota(x)
&&\bigl(\because\ \blkref{inclusion_nn_to_zz_preserves_sum}\ (x \to x \cdot_{\mathbb{N}} y,\ y \to x)\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} \iota(y) +_{\mathbb{Z}} \iota(x)
&&\bigl(\because\ \text{帰納法の仮定}\ \varphi(y)\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} \iota(y) +_{\mathbb{Z}} \iota(x) \cdot_{\mathbb{Z}} 1_{\mathbb{Z}}
&&\bigl(\because\ \mathbb{Z}\ \text{の乗法の単位元}\ x \cdot 1_{\mathbb{Z}} = x\ (x \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} \bigl(\iota(y) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ x \cdot (y + t) = x \cdot y + x \cdot t\ (x \to \iota(x),\ y \to \iota(y),\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \iota(x) \cdot_{\mathbb{Z}} \iota(y +_{\mathbb{N}} 1_{\mathbb{N}})
&&\bigl(\because\ \blkref{inclusion_nn_to_zz}\ \text{の}\ \iota(n +_{\mathbb{N}} 1_{\mathbb{N}}) := \iota(n) +_{\mathbb{Z}} 1_{\mathbb{Z}}\ (n \to y)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\varphi(y +_{\mathbb{N}} 1_{\mathbb{N}})`),
        " も成り立つ。数学的帰納法により、すべての ",
        math(String.raw`y \in \mathbf{N}`),
        " で ",
        math(String.raw`\varphi(y)`),
        " である。",
        math(String.raw`x`),
        " は任意だったので、主張が従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-23（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の続き）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum の準備の鎖が (2(M_col)_ℕ)_ℤ = 2M_col の根拠を「ι_{ℕ→ℤ} は積を保つ」と主張の前置きの仮定で引いていた。inclusion_nn_to_zz の二つの式、inclusion_nn_to_zz_preserves_sum、int_zero_times_is_zero と set_and_algebra_notation の ℕ・ℤ の行から示す主張として足した。Lean の具体版は Ising2D.inclusion_nn_to_zz_preserves_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProduct.lean）、必要十分版は Ising2D.NecSuf.map_mul_of_rec_add_one（NecSuf/MapMulOfRecAddOne.lean）。数値検証: sagemath/check/inclusion_nn_to_zz_preserves_product/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_nn_to_zz_preserves_order",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}\text{ は順序を保つ}` },
    labels: ["inclusion_nn_to_zz_preserves_order"],
    lean: ["Ising2D.inclusion_nn_to_zz_preserves_order"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbf{N}`),
        " が ",
        math(String.raw`x \le_{\mathbb{N}} y`),
        " を満たすなら、",
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " は",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}(x) \le_{\mathbb{Z}} \iota_{\mathbb{N}\to\mathbb{Z}}(y)`),
      paragraph([
        "を満たす。",
        math(String.raw`\le_{\mathbb{N}}`),
        "・",
        math(String.raw`\le_{\mathbb{Z}}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{N}`),
        "・",
        math(String.raw`\mathbb{Z}`),
        " の順序である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x \le_{\mathbb{N}} y`),
        " と ",
        math(String.raw`\mathbb{N}`),
        " の順序と和 ",
        math(String.raw`x \le y \Leftrightarrow \exists d \in \mathbf{N},\ x + d = y`),
        "（",
        ref("set_and_algebra_notation"),
        "）から、",
        math(String.raw`x +_{\mathbb{N}} d = y`),
        " を満たす ",
        math(String.raw`d \in \mathbf{N}`),
        " を取る。以下では ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " を ",
        math(String.raw`\iota`),
        " と略し、鎖の ",
        math(String.raw`\le`),
        " と ",
        math(String.raw`=`),
        " の連なりは ",
        math(String.raw`\mathbb{Z}`),
        " の順序の推移律（",
        ref("set_and_algebra_notation"),
        "）でつなぐ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota(x)
&= 0_{\mathbb{Z}} +_{\mathbb{Z}} \iota(x)
&&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + x = x\ (x \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le \iota(d) +_{\mathbb{Z}} \iota(x)
&&\bigl(\because\ \blkref{inclusion_nn_to_zz_image_is_nonnegative}\ (n \to d)\ \text{に}\ \mathbb{Z}\ \text{の順序と加法の両立}\ x \le y \Rightarrow x + t \le y + t\ (x \to 0_{\mathbb{Z}},\ y \to \iota(d),\ t \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x) +_{\mathbb{Z}} \iota(d)
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換律}\ x + y = y + x\ (x \to \iota(d),\ y \to \iota(x))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota(x +_{\mathbb{N}} d)
&&\bigl(\because\ \blkref{inclusion_nn_to_zz_preserves_sum}\ (y \to d)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota(y)
&&\bigl(\because\ x +_{\mathbb{N}} d = y\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-24（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の続き）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum が主張の前置きで ι_{ℕ→ℤ} を「順序を保つものとする」と仮定し、(M_col)_ℝ ≥ (2_ℤ)_ℝ と N_ℝ ≥ ((1_ℕ)_ℤ)_ℝ の段で引いていた。set_and_algebra_notation の ℕ の順序と和、inclusion_nn_to_zz_image_is_nonnegative、inclusion_nn_to_zz_preserves_sum と ℤ の行から示す主張として足した。Lean の具体版は Ising2D.inclusion_nn_to_zz_preserves_order（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrder.lean）、必要十分版は Ising2D.NecSuf.le_of_map_add_of_nonneg（NecSuf/LeOfMapAddOfNonneg.lean）。数値検証: sagemath/check/inclusion_nn_to_zz_preserves_order/。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_inclusion_zz_to_rr",
    kind: "definition",
    title: { tex: String.raw`\mathbb{Z}\to\mathbb{R}\text{の包含写像}` },
    labels: ["inclusion_zz_to_rr"],
    lean: ["Ising2D.inclusionZZtoRR", "Ising2D.inclusionZZtoRRNonneg", "Ising2D.inclusionZZtoRR_eq_intCast", "Ising2D.inclusion_zz_to_rr_zero", "Ising2D.inclusion_zz_to_rr_succ", "Ising2D.inclusion_zz_to_rr_neg", "Ising2D.inclusion_zz_to_rr_zero_intCast", "Ising2D.inclusion_zz_to_rr_succ_intCast"],
    statement: [
      paragraph([
        ref("set_and_algebra_notation"),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " と ",
        math(String.raw`\mathbb{R}`),
        " を別々の台集合の上の構造として置く。写像 ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}:\mathbb{Z}\to\mathbb{R}`),
        " を次で定める。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " については ",
        math(String.raw`n`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}},
\qquad
\iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}`),
      paragraph([
        "と定める（",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の各元は、",
        math(String.raw`0_{\mathbb{Z}}`),
        " であるか、ただ一つの ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`n +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " と書けるかの、ちょうど一方である）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " については",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)`),
      paragraph([
        "と定める（右辺の ",
        math(String.raw`-`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の符号反転）。",
        math(String.raw`\mathbb{Z}`),
        " の各元は、",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の元であるか、ある ",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`-n`),
        " と書けるかの、ちょうど一方である（後者の ",
        math(String.raw`n`),
        " はただ一つ）ので、各元にただ一つの値が定まる。これを ",
        math(String.raw`\mathbb{Z}`),
        " から ",
        math(String.raw`\mathbb{R}`),
        " への包含写像と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_power_upper_bound の最後の鎖が、行列の大きさ d := 2^{M_col} ∈ ℤ と ℝ の冪 2^{M_col} を「d := 2^{M_col}」の一行で等号で結び、同じ記号を ℤ と ℝ の元に使い回していた（証明の書き方の「同一視をしない」）。ℤ の元を ℝ の計算に入れる写像に名前を付けるために足した。負の元の節 ι(-n) := -ι(n) はこの時点では使われないが、limit_of_log_Z_in_N_row がアルキメデス性で取る N_0 ∈ ℤ（比べる時点では正と分かっていない）を ℝ の元と比べるのに使うので、ℤ 全体で定める。",
        "2026-11-24（Lean の点検の直し、未定義の記号の行「本文の ℤ_{≥k} と Lean の ℕ の間の写像」の前提）: 本文は変えていない。Lean にこの定義どおりの具体版 inclusionZZtoRR（ℤ_{≥0} の側は inclusionZZtoRRNonneg）と Lean の Int.cast との一致の補題 inclusionZZtoRR_eq_intCast を置き、欄 lean の先頭に足した。定義の式 ι(-n) := -ι(n) の具体版 inclusion_zz_to_rr_neg は inclusionZZtoRR の定義の式を一致の補題で移す形にした。Lean の Int.cast（ℝ へ）を許可の一覧にこのブロックのラベルで載せた。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_inclusion_nn_to_rr",
    kind: "definition",
    title: { tex: String.raw`\mathbb{N}\to\mathbb{R}\text{の包含写像}` },
    labels: ["inclusion_nn_to_rr"],
    lean: ["Ising2D.inclusionNNtoRR", "Ising2D.inclusionNNtoRR_eq_natCast"],
    statement: [
      paragraph([
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        " と ",
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " を合成して、写像 ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{R}}:\mathbb{N}\to\mathbb{R}`),
        " を",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{R}}(n) := \iota_{\mathbb{Z}\to\mathbb{R}}(\iota_{\mathbb{N}\to\mathbb{Z}}(n))
\qquad (n \in \mathbb{N})`),
      paragraph([
        "と定める。これを ",
        math(String.raw`\mathbb{N}`),
        " から ",
        math(String.raw`\mathbb{R}`),
        " への包含写像と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-27（Lean の点検の直し、未定義の記号の行「ℝ の数・順序・差・商」の残りの Nat.cast@Real）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum が略記 n_ℝ := (n_ℤ)_ℝ（n ∈ ℕ）を置いていたが、この写像を定めるブロックが無かった。antiperiodic_exp_sum の略記をこのブロックの ι_{ℕ→ℝ} に結び付けた（定義の右辺は元の略記と同じ合成である）。Lean の具体版は ℤ_{≥0} の元を ℕ の元 n の像 ι_{ℕ→ℤ}(n) として書き、それを ℝ へ送るのに Lean の Nat.cast を使うので、その写像を名前の付いた二つの写像の合成として定めた。Lean の具体版は Ising2D.inclusionNNtoRR（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionInclusionOfNaturalNumbersIntoRealNumbers.lean。同じ合成で定める）で、Lean の Nat.cast（ℕ → ℝ）との一致は補題一本 Ising2D.inclusionNNtoRR_eq_natCast である。定義であり証明を持たないので、SageMath の検算は置かない。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_inclusion_nn_to_cc",
    kind: "definition",
    title: { tex: String.raw`\mathbb{N}\to\mathbb{C}\text{の包含写像}` },
    labels: ["inclusion_nn_to_cc"],
    lean: ["Ising2D.inclusionNNtoCC", "Ising2D.inclusionNNtoCC_eq_natCast"],
    statement: [
      paragraph([
        ref("inclusion_nn_to_zz"),
        " の ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{Z}}`),
        "、",
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        "、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " を合成して、写像 ",
        math(String.raw`\iota_{\mathbb{N}\to\mathbb{C}}:\mathbb{N}\to\mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\iota_{\mathbb{N}\to\mathbb{C}}(n) := \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(\iota_{\mathbb{N}\to\mathbb{Z}}(n))\bigr)_{\mathbb{C}}
\qquad (n \in \mathbb{N})`),
      paragraph([
        "と定める。これを ",
        math(String.raw`\mathbb{N}`),
        " から ",
        math(String.raw`\mathbb{C}`),
        " への包含写像と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-27（Lean の点検の直し、未定義の記号の行「ℂ とその演算」の残りの Nat.cast@Complex）: 原文（Typst）に対応ブロックは無い。antiperiodic_exp_sum が略記 n_ℂ := ((n_ℤ)_ℝ)_ℂ（n ∈ ℕ）を置き、証明で ((M_col)_ℕ)_ℂ を使っていたが、この写像を定めるブロックが無かった。antiperiodic_exp_sum の略記をこのブロックの ι_{ℕ→ℂ} に結び付けた（定義の右辺は元の略記と同じ合成である）。Lean の具体版は ℤ_{≥0} の元を ℕ の元 n の像 ι_{ℕ→ℤ}(n) として書き、それを ℂ へ送るのに Lean の Nat.cast を使うので、その写像を名前の付いた三つの写像の合成として定めた。Lean の具体版は Ising2D.inclusionNNtoCC（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionInclusionOfNaturalNumbersIntoComplexNumbers.lean。同じ合成で定める）で、Lean の Nat.cast（ℕ → ℂ）との一致は補題一本 Ising2D.inclusionNNtoCC_eq_natCast である。定義であり証明を持たないので、SageMath の検算は置かない。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_of_one",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}}) = 1_{\mathbb{R}}` },
    labels: ["inclusion_zz_to_rr_of_one"],
    lean: ["Ising2D.inclusion_zz_to_rr_of_one", "Ising2D.inclusion_zz_to_rr_of_one_intCast"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}}) = 1_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ (n \to 0_{\mathbb{Z}})\bigr)\\
&= 0_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&= 1_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07: 原文（Typst）に対応ブロックは無い。finite_sum_of_constant_real_number と inclusion_zz_to_rr_of_power_of_two の帰納法の出発点で使うので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_preserves_sum_of_nonnegatives",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a+b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a)+\iota_{\mathbb{Z}\to\mathbb{R}}(b)\quad(a, b \geq 0)` },
    labels: ["inclusion_zz_to_rr_preserves_sum_of_nonnegatives"],
    lean: ["Ising2D.inclusion_zz_to_rr_preserves_sum_of_nonnegatives", "Ising2D.inclusion_zz_to_rr_preserves_sum_of_nonnegatives_intCast"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        " を固定し、",
        math(String.raw`b`),
        " についての帰納法で示す。",
        math(String.raw`b = 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} 0_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`b \in \mathbb{Z}_{\geq 0}`),
        " で主張が成り立つと仮定すると、",
        math(String.raw`a +_{\mathbb{Z}} b \in \mathbb{Z}_{\geq 0}`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b +_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a +_{\mathbb{Z}} b) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} b) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ (n \to a +_{\mathbb{Z}} b)\bigr)\\
&= \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b +_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ (n \to b)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`b +_{\mathbb{Z}} 1_{\mathbb{Z}}`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07: 原文（Typst）に対応ブロックは無い。inclusion_zz_to_rr_of_power_of_two の帰納法の段で ι(2^M + 2^M) を分けるのに使うので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_of_successor",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n+1) = \iota_{\mathbb{Z}\to\mathbb{R}}(n)+1\quad(n \in \mathbb{Z})` },
    labels: ["inclusion_zz_to_rr_of_successor"],
    lean: ["Ising2D.inclusion_zz_to_rr_of_successor"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`n \in \mathbb{Z}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) = \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}`),
      paragraph([
        "である（",
        ref("inclusion_zz_to_rr"),
        " はこの式を ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " についてだけ定めている）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " のとおり ",
        math(String.raw`\mathbb{Z}`),
        " の各元は、",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の元であるか、ある ",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`-m`),
        " と書けるかの、ちょうど一方である。",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元 ",
        math(String.raw`m`),
        " は、",
        math(String.raw`1_{\mathbb{Z}}`),
        " であるか、ある ",
        math(String.raw`p \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`p +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " と書けるかの、ちょうど一方である。よって ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`n = -1_{\mathbb{Z}}`),
        "、",
        math(String.raw`n = -(p +_{\mathbb{Z}} 1_{\mathbb{Z}})`),
        "（",
        math(String.raw`p \in \mathbb{Z}_{\geq 1}`),
        "）の 3 つの場合に分ける。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)
\end{aligned}`),
      paragraph(["である。", math(String.raw`n = -1_{\mathbb{Z}}`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl((-1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
  &&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-x) + x = 0_{\mathbb{Z}}\ (x \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&= (-1_{\mathbb{R}}) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ (-1_{\mathbb{R}}) +_{\mathbb{R}} 1_{\mathbb{R}} = 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_one}\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(-1_{\mathbb{Z}}) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)\ (n \to 1_{\mathbb{Z}})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n = -(p +_{\mathbb{Z}} 1_{\mathbb{Z}})`),
        "（",
        math(String.raw`p \in \mathbb{Z}_{\geq 1}`),
        "）のとき、",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`p +_{\mathbb{Z}} 1_{\mathbb{Z}} \in \mathbb{Z}_{\geq 1}`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(-(p +_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\Bigl(\bigl((-p) +_{\mathbb{Z}} (-1_{\mathbb{Z}})\bigr) +_{\mathbb{Z}} 1_{\mathbb{Z}}\Bigr)
  &&\bigl(\because\ \blkref{int_negation_of_sum_is_sum_of_negations}\ (x \to p,\ y \to 1_{\mathbb{Z}})\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\Bigl((-p) +_{\mathbb{Z}} \bigl((-1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)\Bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to -p,\ y \to -1_{\mathbb{Z}},\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((-p) +_{\mathbb{Z}} 0_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の加法の逆元}\ (-x) + x = 0_{\mathbb{Z}}\ (x \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(-p)
  &&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ x + 0_{\mathbb{Z}} = x\ (x \to -p)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -\iota_{\mathbb{Z}\to\mathbb{R}}(p)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)\ (n \to p)\bigr)\\
&= \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(p)\bigr) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(p)\bigr) +_{\mathbb{R}} \bigl((-1_{\mathbb{R}}) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ (-1_{\mathbb{R}}) +_{\mathbb{R}} 1_{\mathbb{R}} = 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(p)\bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})\Bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律を右辺から左辺へ}\bigr)\\
&= -\bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(p) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ (x \to \iota_{\mathbb{Z}\to\mathbb{R}}(p),\ y \to 1_{\mathbb{R}})\ \text{を右辺から左辺へ}\bigr)\\
&= -\iota_{\mathbb{Z}\to\mathbb{R}}(p +_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ (n \to p)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(-(p +_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)\ (n \to p +_{\mathbb{Z}} 1_{\mathbb{Z}})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w49b2)）: 原文（Typst）に対応ブロックは無い。inclusion_zz_to_rr は ι(n + 1) := ι(n) + 1 を n ∈ ℤ_{≥0} についてだけ定めるので、ℤ 全体で和を保つ主張 inclusion_zz_to_rr_preserves_sum の帰納法の段で引けるよう、ℤ 全体の場合を示す主張として足した。Lean の具体版は Ising2D.inclusion_zz_to_rr_of_successor、必要十分版は Ising2D.NecSuf.int_cast_succ'。数値検証: sagemath/check/inclusion_zz_to_rr_of_successor/。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: n = −(p + 1) の場合で「ℤ の四則 −(p + 1) + 1 = −p」と名前だけで引いていた 1 行を、int_negation_of_sum_is_sum_of_negations（x → p, y → 1）と set_and_algebra_notation の ℤ の加法の結合律・加法の逆元・和の単位元の 4 行に割った。n = −1 の場合の「ℤ の加法逆元」の行にも set_and_algebra_notation の参照と一覧の形を書いた。鎖の両端と主張は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_preserves_sum",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a+b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a)+\iota_{\mathbb{Z}\to\mathbb{R}}(b)\quad(a, b \in \mathbb{Z})` },
    labels: ["inclusion_zz_to_rr_preserves_sum"],
    lean: ["Ising2D.inclusion_zz_to_rr_preserves_sum"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a, b \in \mathbb{Z}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`a \in \mathbb{Z}`),
        " を固定する。",
        math(String.raw`\mathbb{Z}`),
        " の各元は ",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " か ",
        math(String.raw`\mathbb{Z}_{\leq 0}`),
        " の元であり、",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の元は ",
        math(String.raw`0_{\mathbb{Z}}`),
        " から ",
        math(String.raw`1_{\mathbb{Z}}`),
        " を足すことを、",
        math(String.raw`\mathbb{Z}_{\leq 0}`),
        " の元は ",
        math(String.raw`0_{\mathbb{Z}}`),
        " から ",
        math(String.raw`1_{\mathbb{Z}}`),
        " を引くことを有限回繰り返して得られる。よって ",
        math(String.raw`b = 0_{\mathbb{Z}}`),
        " で主張を示し、",
        math(String.raw`b`),
        " で成り立てば ",
        math(String.raw`b \in \mathbb{Z}_{\geq 0}`),
        " のとき ",
        math(String.raw`b +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " で、",
        math(String.raw`b \in \mathbb{Z}_{\leq 0}`),
        " のとき ",
        math(String.raw`b -_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " で成り立つことを示す。",
        math(String.raw`b = 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} 0_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`b \in \mathbb{Z}_{\geq 0}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b +_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a +_{\mathbb{Z}} b) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} b) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to a +_{\mathbb{Z}} b)\bigr)\\
&= \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b +_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to b)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`b \in \mathbb{Z}_{\leq 0}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} \bigl(1_{\mathbb{R}} +_{\mathbb{R}} (-1_{\mathbb{R}})\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ 1_{\mathbb{R}} +_{\mathbb{R}} (-1_{\mathbb{R}}) = 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} 1_{\mathbb{R}}\Bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\Bigl(\bigl(a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{Z}} 1_{\mathbb{Z}}\Bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to a +_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}}))\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\Bigl(a +_{\mathbb{Z}} \bigl((b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)\Bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})
  &&\bigl(\because\ \mathbb{Z}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to a,\ y \to b -_{\mathbb{Z}} 1_{\mathbb{Z}},\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} b) +_{\mathbb{R}} (-1_{\mathbb{R}})
  &&\bigl(\because\ \blkref{int_difference_plus_subtrahend_is_original}\ (x \to b,\ y \to 1_{\mathbb{Z}})\bigr)\\
&= \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} (-1_{\mathbb{R}})\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}\bigl((b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})\Bigr)
  &&\bigl(\because\ \blkref{int_difference_plus_subtrahend_is_original}\ (x \to b,\ y \to 1_{\mathbb{Z}})\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \Bigl(\bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr) +_{\mathbb{R}} (-1_{\mathbb{R}})\Bigr)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} \bigl(1_{\mathbb{R}} +_{\mathbb{R}} (-1_{\mathbb{R}})\bigr)\Bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} 0_{\mathbb{R}}\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ 1_{\mathbb{R}} +_{\mathbb{R}} (-1_{\mathbb{R}}) = 0_{\mathbb{R}}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w49b2)）: 原文（Typst）に対応ブロックは無い。periodicity_of_check_fermi の準備の第二と (2) の θ̃_{μ+kM_col} の鎖、half_integer_phase_periodicity の準備の鎖が、符号の決まっていない ℤ の元の和について「ι_{ℤ→ℝ} は和を保つ」を名前だけで使っていた（inclusion_zz_to_rr_preserves_sum_of_nonnegatives は a, b ∈ ℤ_{≥0} だけ）ので、ℤ 全体の主張として足した。Lean の具体版は Ising2D.inclusion_zz_to_rr_preserves_sum、必要十分版は Ising2D.NecSuf.int_cast_add'。数値検証: sagemath/check/inclusion_zz_to_rr_preserves_sum/。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: b ∈ ℤ_{≤0} の段で「ℤ の四則」と名前だけで引いていた 2 か所を直した。(a + (b − 1)) + 1 = a + b の行は、ℤ の加法の結合律（set_and_algebra_notation）の行と int_difference_plus_subtrahend_is_original（x → b, y → 1）の行の 2 行に割り、b = (b − 1) + 1 の行は int_difference_plus_subtrahend_is_original を右辺から左辺へ引く形にした。鎖の両端と主張は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_preserves_product",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(ab) = \iota_{\mathbb{Z}\to\mathbb{R}}(a)\,\iota_{\mathbb{Z}\to\mathbb{R}}(b)\quad(a, b \in \mathbb{Z})` },
    labels: ["inclusion_zz_to_rr_preserves_product"],
    lean: ["Ising2D.inclusion_zz_to_rr_preserves_product"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a, b \in \mathbb{Z}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a \cdot_{\mathbb{Z}} b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`a \in \mathbb{Z}`),
        " を固定する。",
        ref("inclusion_zz_to_rr_preserves_sum"),
        " の証明と同じく、",
        math(String.raw`b = 0_{\mathbb{Z}}`),
        " で主張を示し、",
        math(String.raw`b`),
        " で成り立てば ",
        math(String.raw`b \in \mathbb{Z}_{\geq 0}`),
        " のとき ",
        math(String.raw`b +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " で、",
        math(String.raw`b \in \mathbb{Z}_{\leq 0}`),
        " のとき ",
        math(String.raw`b -_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " で成り立つことを示す（",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の元は ",
        math(String.raw`0_{\mathbb{Z}}`),
        " から ",
        math(String.raw`1_{\mathbb{Z}}`),
        " を足すことを、",
        math(String.raw`\mathbb{Z}_{\leq 0}`),
        " の元は ",
        math(String.raw`0_{\mathbb{Z}}`),
        " から ",
        math(String.raw`1_{\mathbb{Z}}`),
        " を引くことを有限回繰り返して得られる）。",
        math(String.raw`b = 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(a \cdot_{\mathbb{Z}} 0_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}} \cdot_{\mathbb{Z}} a)
  &&\bigl(\because\ \mathbb{Z}\ \text{の乗法の交換律}\ x \cdot y = y \cdot x\ (x \to a,\ y \to 0_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{int_zero_times_is_zero}\ (x \to a)\bigr)\\
&= 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x \to \iota_{\mathbb{Z}\to\mathbb{R}}(a))\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`b \in \mathbb{Z}_{\geq 0}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b +_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} a \cdot_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ x \cdot (y + t) = x \cdot y + x \cdot t\ (x \to a,\ y \to b,\ t \to 1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} a\bigr)
  &&\bigl(\because\ 1_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の積の単位元}\ x \cdot 1_{\mathbb{Z}} = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a \cdot_{\mathbb{Z}} b) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_sum}\ (a \to a \cdot_{\mathbb{Z}} b,\ b \to a)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の積の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の分配律を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b +_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to b)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`b \in \mathbb{Z}_{\leq 0}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)\Bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ x +_{\mathbb{R}} (-x) = 0_{\mathbb{R}}\ (x \to \iota_{\mathbb{Z}\to\mathbb{R}}(a))\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)\Bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_sum}\ (a \to a \cdot_{\mathbb{Z}} (b -_{\mathbb{Z}} 1_{\mathbb{Z}}),\ b \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a \cdot_{\mathbb{Z}} \bigl(b +_{\mathbb{Z}} (-1_{\mathbb{Z}})\bigr) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{def_int_difference}\ (y \to b,\ z \to 1_{\mathbb{Z}})\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} a \cdot_{\mathbb{Z}} (-1_{\mathbb{Z}})\bigr) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の分配律}\ x \cdot (y + t) = x \cdot y + x \cdot t\ (x \to a,\ y \to b,\ t \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} (-1_{\mathbb{Z}}) \cdot_{\mathbb{Z}} a\bigr) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の乗法の交換律}\ x \cdot y = y \cdot x\ (x \to a,\ y \to -1_{\mathbb{Z}})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} \bigl(-(1_{\mathbb{Z}} \cdot_{\mathbb{Z}} a)\bigr)\bigr) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{int_negation_times_is_negation_of_product}\ (x \to 1_{\mathbb{Z}},\ t \to a)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(\bigl(a \cdot_{\mathbb{Z}} b +_{\mathbb{Z}} \bigl(-(a \cdot_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)\bigr) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の乗法の交換律}\ x \cdot y = y \cdot x\ (x \to 1_{\mathbb{Z}},\ y \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a \cdot_{\mathbb{Z}} b -_{\mathbb{Z}} a \cdot_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{def_int_difference}\ (y \to a \cdot_{\mathbb{Z}} b,\ z \to a \cdot_{\mathbb{Z}} 1_{\mathbb{Z}})\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a \cdot_{\mathbb{Z}} b -_{\mathbb{Z}} a) +_{\mathbb{Z}} a\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ 1_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の積の単位元}\ x \cdot 1_{\mathbb{Z}} = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a \cdot_{\mathbb{Z}} b) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{int_difference_plus_subtrahend_is_original}\ (x \to a \cdot_{\mathbb{Z}} b,\ y \to a)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{int_difference_plus_subtrahend_is_original}\ (x \to b,\ y \to 1_{\mathbb{Z}})\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_successor}\ (n \to b -_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)\\
&= \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} 1_{\mathbb{R}}\Bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の分配律}\bigr)\\
&= \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)\Bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の積の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)\Bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}}) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ x +_{\mathbb{R}} (-x) = 0_{\mathbb{R}}\ (x \to \iota_{\mathbb{Z}\to\mathbb{R}}(a))\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) \cdot_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b -_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w49b3)）: 原文（Typst）に対応ブロックは無い。periodicity_of_check_fermi (2) の θ̃_{μ+kM_col} の鎖の 3 行目が、符号の決まっていない k ∈ ℤ と M_col の積について「ι_{ℤ→ℝ} は積を保つ」を名前だけで使っていたので、ℤ 全体の主張として足した。証明は inclusion_zz_to_rr_preserves_sum と同じ 2 方向の帰納法で、和の保存と後者の主張だけを引く。b = 0 の行が引く real_times_zero_is_zero は後ろのファイル 000_calculation_formulae_20_29.ts にあり、前方参照になる（状態台帳の定義より前の参照の件で扱う）。Lean の具体版は Ising2D.inclusion_zz_to_rr_preserves_product、必要十分版は Ising2D.NecSuf.int_cast_mul'。数値検証: sagemath/check/inclusion_zz_to_rr_preserves_product/。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: b ∈ ℤ_{≤0} の段で「ℤ の四則」と名前だけで引いていた (x − a) + a = x（x → ab）と b = (b − 1) + 1 の 2 か所を、int_difference_plus_subtrahend_is_original を引く形にした。鎖の両端と主張は不変。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の分配律」）: b ∈ ℤ_{≤0} の段で「ℤ の分配律」と名前だけで引いていた a(b − 1) = ab − a·1 の 1 行を、def_int_difference・set_and_algebra_notation の ℤ の分配律と乗法の交換律・int_negation_times_is_negation_of_product（x → 1, t → a）・def_int_difference を右辺から左辺への 6 行に割った（b ∈ ℤ_{≤0} の段は 20 行になった。x(y − z) = xy − xz を別の主張に切り出さないのは、この主張が最終定理に繋がっておらず、切り出した主張の具体版が繋がりの台帳に新しい行を足すため）。b = 0 の段の「ℤ で a·0 = 0」と名前だけで引いていた 1 行を、set_and_algebra_notation の ℤ の乗法の交換律と int_zero_times_is_zero（x → a）の 2 行に割った（b = 0 の段は 5 行になった）。b ∈ ℤ_{≥0} の段の ℤ の分配律と、両方の段の ℤ の積の単位元の行には set_and_algebra_notation の参照と一覧の形を書いた。鎖の両端と主張は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_preserves_difference",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a - b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a) - \iota_{\mathbb{Z}\to\mathbb{R}}(b)\quad(a, b \in \mathbb{Z})` },
    labels: ["inclusion_zz_to_rr_preserves_difference"],
    lean: ["Ising2D.inclusion_zz_to_rr_preserves_difference"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a, b \in \mathbb{Z}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a -_{\mathbb{Z}} b) = \iota_{\mathbb{Z}\to\mathbb{R}}(a) -_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)`),
      paragraph([
        "である。右辺の ",
        math(String.raw`-_{\mathbb{R}}`),
        " は ",
        ref("def_real_difference"),
        " の差である。",
      ]),
    ],
    proof: [
      paragraph(["主張の左辺から"]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(a -_{\mathbb{Z}} b)
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a -_{\mathbb{Z}} b) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a -_{\mathbb{Z}} b) +_{\mathbb{R}} \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(b) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)\Bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ x +_{\mathbb{R}} (-x) = 0_{\mathbb{R}}\ (x \to \iota_{\mathbb{Z}\to\mathbb{R}}(b))\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(a -_{\mathbb{Z}} b) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)\Bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の和の結合律を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a -_{\mathbb{Z}} b) +_{\mathbb{Z}} b\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_sum}\ (a \to a -_{\mathbb{Z}} b,\ b \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl((a +_{\mathbb{Z}} (-b)) +_{\mathbb{Z}} b\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ \blkref{def_int_difference}\ (y \to a,\ z \to b)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(a +_{\mathbb{Z}} ((-b) +_{\mathbb{Z}} b)\bigr) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の和の結合律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} 0_{\mathbb{Z}}) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の加法逆元}\ (-x) +_{\mathbb{Z}} x = 0_{\mathbb{Z}}\ (x \to b)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(b)\bigr)
  &&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) -_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(b)
  &&\bigl(\because\ \blkref{def_real_difference}\ (y \to \iota_{\mathbb{Z}\to\mathbb{R}}(a),\ z \to \iota_{\mathbb{Z}\to\mathbb{R}}(b))\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w49b4)）: 原文（Typst）に対応ブロックは無い。def_half_integer_modes (3)・conjugate_index_of_check_Z_Y (1) の鎖の 2 行目と recover_Z_Y_from_check_Z_Y の準備 2 の実数の鎖の 4 行目（いずれも eigenvalue_problem_diagonalization_and_exponential_form.ts）が「ι_{ℤ→ℝ} は和と零を保つので差を保つ」を名前だけで使っていたので、ℤ 全体の主張として足した。証明は inclusion_zz_to_rr_preserves_sum だけを引く 6 行の鎖である。Lean の具体版は Ising2D.inclusion_zz_to_rr_preserves_difference、必要十分版は Ising2D.NecSuf.int_cast_sub'。数値検証: sagemath/check/inclusion_zz_to_rr_preserves_difference/。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の差・狭義の順序・数字」）: 鎖の 5 行目の名前だけの根拠「ℤ の四則 (x − b) + b = x」を、def_int_difference・ℤ の和の結合律・ℤ の加法逆元 (−x) + x = 0・ℤ の和の単位元の 4 行に割った（鎖は 9 行）。Lean の具体版の sub_add_cancel の 1 段も同じ 4 段にした。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_preserves_negation",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(-a) = -\iota_{\mathbb{Z}\to\mathbb{R}}(a)\quad(a \in \mathbb{Z})` },
    labels: ["inclusion_zz_to_rr_preserves_negation"],
    lean: ["Ising2D.inclusion_zz_to_rr_preserves_negation"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a \in \mathbb{Z}`),
        " なら",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(-a) = -\iota_{\mathbb{Z}\to\mathbb{R}}(a)`),
      paragraph([
        "である。左辺の ",
        math(String.raw`-`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の符号反転、右辺の ",
        math(String.raw`-`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の符号反転である（",
        ref("inclusion_zz_to_rr"),
        " の負の元の節 ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)`),
        " は ",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " だけを覆い、この主張は ",
        math(String.raw`a`),
        " の符号を問わない）。",
      ]),
    ],
    proof: [
      paragraph(["主張の左辺から"]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(-a)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(0_{\mathbb{Z}} +_{\mathbb{Z}} (-a)\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の和の単位元}\ 0_{\mathbb{Z}} + x = x\ (x \to -a)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}} -_{\mathbb{Z}} a)
  &&\bigl(\because\ \blkref{def_int_difference}\ (y \to 0_{\mathbb{Z}},\ z \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) -_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_difference}\ (a \to 0_{\mathbb{Z}},\ b \to a)\bigr)\\
&= 0_{\mathbb{R}} -_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&= 0_{\mathbb{R}} +_{\mathbb{R}} \bigl(-\iota_{\mathbb{Z}\to\mathbb{R}}(a)\bigr)
  &&\bigl(\because\ \blkref{def_real_difference}\ (y \to 0_{\mathbb{R}},\ z \to \iota_{\mathbb{Z}\to\mathbb{R}}(a))\bigr)\\
&= -\iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w49b5)）: 原文（Typst）に対応ブロックは無い。anticommutator_of_check_Z_Y の準備 2 の実数の鎖（eigenvalue_problem_diagonalization_and_exponential_form.ts）が「ι_{ℤ→ℝ} は和・零・単位元を保つので差と加法の逆元を保ち」を 1 行で名前だけで使っていたので、その行を割るために、符号を問わない ℤ の元の符号反転を保つ主張として足した。証明は inclusion_zz_to_rr_preserves_difference と定義の ι(0_ℤ) := 0_ℝ を引く 5 行の鎖である。Lean の具体版は Ising2D.inclusion_zz_to_rr_preserves_negation、必要十分版は Ising2D.NecSuf.int_cast_neg'。数値検証: sagemath/check/inclusion_zz_to_rr_preserves_negation/。",
        "2026-11-23（Lean の点検の直し、未定義の記号の行「ℤ の狭義の順序・数字」の残りのうち「ℤ の四則」）: 最初の行の「ℤ の四則 −x = 0 − x」を、ℤ の和の単位元 0 + y = y（set_and_algebra_notation）を右辺から左辺へ引く行と def_int_difference を右辺から左辺へ引く行の 2 行に割った。鎖の両端と主張は不変。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_of_positive_is_at_least_one",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n) \geq 1_{\mathbb{R}}\quad(n \geq 1)` },
    labels: ["inclusion_zz_to_rr_of_positive_is_at_least_one"],
    lean: ["Ising2D.inclusion_zz_to_rr_of_positive_is_at_least_one"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " なら ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n) \geq 1_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n = 1_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})
&= 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_one}\bigr)\\
&\geq 1_{\mathbb{R}}
  &&\bigl(\because\ \leq_{\mathbb{R}}\ \text{の反射律}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " で主張が成り立つと仮定すると、",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}})
&= \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)\\
&\geq 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}
  &&\bigl(\because\ \text{帰納法の仮定}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n) \geq 1_{\mathbb{R}}\ \text{の両辺に}\ 1_{\mathbb{R}}\ \text{を足す}\bigr)\\
&\geq 1_{\mathbb{R}} +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ 1_{\mathbb{R}} \geq 0_{\mathbb{R}}\ \text{の両辺に}\ 1_{\mathbb{R}}\ \text{を足す}\bigr)\\
&= 1_{\mathbb{R}}
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`n +_{\mathbb{Z}} 1_{\mathbb{Z}}`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。limit_of_log_Z_in_N_row で ℤ_{≥1} の元 M_col・N_row を ι_{ℤ→ℝ} で送った値が ℝ_{>0} に住むこと（割る数が正であること）を引けるよう足した。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_of_nonpositive_is_nonpositive",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n) \leq 0_{\mathbb{R}}\quad(n \leq 0)` },
    labels: ["inclusion_zz_to_rr_of_nonpositive_is_nonpositive"],
    lean: ["Ising2D.inclusion_zz_to_rr_of_nonpositive_is_nonpositive"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`n \in \mathbb{Z}_{\leq 0}`),
        " なら ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(n) \leq 0_{\mathbb{R}}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathbb{Z}_{\leq 0}`),
        " の元は、",
        math(String.raw`0_{\mathbb{Z}}`),
        " であるか、ある ",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`-m`),
        " と書けるかの、ちょうど一方である。",
        math(String.raw`n = 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
&= 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&\leq 0_{\mathbb{R}}
  &&\bigl(\because\ \leq_{\mathbb{R}}\ \text{の反射律}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n = -m`),
        "（",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "）のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(-m)
&= -\iota_{\mathbb{Z}\to\mathbb{R}}(m)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(-n) := -\iota_{\mathbb{Z}\to\mathbb{R}}(n)\ (n \to m)\bigr)\\
&\leq -1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_positive_is_at_least_one}\ (n \to m)\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(m) \geq 1_{\mathbb{R}}\ \text{の両辺の符号を反転する。符号を反転すると不等号の向きが変わる}\bigr)\\
&\leq -0_{\mathbb{R}}
  &&\bigl(\because\ 1_{\mathbb{R}} \geq 0_{\mathbb{R}}\ \text{の両辺の符号を反転する}\bigr)\\
&= 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{real_negation_of_zero_is_zero}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。limit_of_log_Z_in_N_row がアルキメデス性で取る N_0 ∈ ℤ について、0_ℝ < ι_{ℤ→ℝ}(N_0) から N_0 ∈ ℤ_{≥1} を導く段（この主張の対偶）で引けるよう足した。inclusion_zz_to_rr の負の元の節を使う最初の主張である。",
        "2026-11-16（Lean の通しの証明のゴールラインの確認）: n = -m の鎖の最後の行 −0_ℝ = 0_ℝ の根拠が式そのものの名前だけだったので、real_negation_of_zero_is_zero の参照に替えた（式と主張は不変）。Lean の具体版の同じ段も mathlib の neg_zero から Ising2D.real_negation_of_zero_is_zero に替えた。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_inclusion_zz_to_rr_is_monotone_on_nonnegatives",
    kind: "claim",
    title: { tex: String.raw`a \leq b \Rightarrow \iota_{\mathbb{Z}\to\mathbb{R}}(a) \leq \iota_{\mathbb{Z}\to\mathbb{R}}(b)\quad(a, b \geq 0)` },
    labels: ["inclusion_zz_to_rr_is_monotone_on_nonnegatives"],
    lean: ["Ising2D.inclusion_zz_to_rr_is_monotone_on_nonnegatives"],
    statement: [
      paragraph([
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " について、",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " が ",
        math(String.raw`a \leq b`),
        " を満たすなら ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(a) \leq \iota_{\mathbb{Z}\to\mathbb{R}}(b)`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k := b -_{\mathbb{Z}} a`),
        " と置く。",
        math(String.raw`a \leq b`),
        " より ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mathbb{Z}`),
        " の四則より ",
        math(String.raw`b = a +_{\mathbb{Z}} k`),
        " である。",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(k) \geq 0_{\mathbb{R}}`),
        " を、",
        math(String.raw`k = 0_{\mathbb{Z}}`),
        " と ",
        math(String.raw`k \in \mathbb{Z}_{\geq 1}`),
        " に分けて示す。",
        math(String.raw`k = 0_{\mathbb{Z}}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})
&= 0_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\bigr)\\
&\geq 0_{\mathbb{R}}
  &&\bigl(\because\ \leq_{\mathbb{R}}\ \text{の反射律}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`k \in \mathbb{Z}_{\geq 1}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(k)
&\geq 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_positive_is_at_least_one}\ (n \to k)\bigr)\\
&\geq 0_{\mathbb{R}}
  &&\bigl(\because\ 1_{\mathbb{R}} \geq 0_{\mathbb{R}}\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}(b)
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a +_{\mathbb{Z}} k)
  &&\bigl(\because\ b = a +_{\mathbb{Z}} k\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}(k)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_sum_of_nonnegatives}\ (b \to k)\bigr)\\
&\geq \iota_{\mathbb{Z}\to\mathbb{R}}(a) +_{\mathbb{R}} 0_{\mathbb{R}}
  &&\bigl(\because\ \text{上の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(k) \geq 0_{\mathbb{R}}\ \text{の両辺に}\ \iota_{\mathbb{Z}\to\mathbb{R}}(a)\ \text{を足す}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(a)
  &&\bigl(\because\ 0_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。limit_of_log_Z_in_N_row の最後の評価で、1 ≤ N_0 ≤ N_row（ℤ）から ι_{ℤ→ℝ}(N_0) ≤ ι_{ℤ→ℝ}(N_row)（ℝ）を引けるよう足した。",
      ],
    },
  },
  {
    id: "calc_formulae_008_multiply_by_minus_one",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/008_definition_マイナス1倍.typ", ordinal: 9 },
    title: { tex: "-1\\text{倍}" },
    labels: ["multiply_by_minus_one"],
    lean: ["Ising2D.complex_neg_eq_ofReal_neg_one_mul"],
    statement: [
      paragraph([math("z\\in\\mathbb{C}"), " について、"]),
      displayMath("-z:=(-1_{\\mathbb{C}})\\cdot z"),
      paragraph([
        "と定める。右辺の ",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb{C}}`),
        " の ",
        math(String.raw`r = -1`),
        "、積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-22（Lean の点検の直し）: 右辺の -1_ℂ が何であるかを書いていなかったので、minus_one_times_minus_one_is_one_in_cc と同じく inclusion_rr_to_cc の略記 r_ℂ の r = -1 であること、積が definition_of_cc の積であることを書き足した。定義の中身は変えていない。",
      ],
    },
  },
  {
    id: "calc_formulae_008b_definition_complex_difference",
    kind: "definition",
    title: { text: "複素数の差" },
    labels: ["def_complex_difference"],
    lean: ["Ising2D.complex_sub_eq_add_neg"],
    statement: [
      paragraph([
        math(String.raw`z, w \in \mathbb{C}`),
        " について、差 ",
        math(String.raw`z - w \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`z - w := z + (-w)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`-w`),
        " は ",
        ref("multiply_by_minus_one"),
        "、和は ",
        ref("definition_of_cc"),
        " の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。ℂ の差は本文全体で使われていたが、定めるブロックが無く、行列の差の定義（def_matrix_difference）も「複素数の差」を根拠にしていた。star_preserves_norm_and_limits の検算で、複素共役が差を保つことを示すのに要るので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_008c_definition_finite_sum_of_complex_numbers",
    kind: "definition",
    title: { text: "複素数の有限和" },
    labels: ["def_finite_sum_of_complex_numbers"],
    lean: ["Ising2D.finset_sum_fin_complex_eq_finite_sum_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        "（添字の集合 ",
        math(String.raw`\{1,\dots,m\}`),
        "（",
        ref("def_index_set_from_one_to_n"),
        "）から ",
        math(String.raw`\mathbb{C}`),
        " への写像。",
        math(String.raw`m = 0`),
        " のときは添字の集合が空で、項を一つも持たない）について、有限和 ",
        math(String.raw`\sum_{j=1}^{m} z_j \in \mathbb{C}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{j=1}^{0} z_j := 0_{\mathbb{C}},
\qquad
\sum_{j=1}^{1} z_j := z_1,
\qquad
\sum_{j=1}^{m+1} z_j := \Bigl(\sum_{j=1}^{m} z_j\Bigr) + z_{m+1}\quad (m \in \mathbb{Z}_{\geq 1})`),
      paragraph([
        "と定める（左から順に足す）。和は ",
        ref("definition_of_cc"),
        " の和、",
        math(String.raw`0_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列の積（mat_mult）をはじめ本文全体が有限和を使っていたが、定めるブロックが無かった。complex_conjugate_of_sum の帰納法の各行が引けるよう足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の二単位目）: 項の無い族の和 Σ_{j=1}^{0} z_j := 0_ℂ を足し、m の範囲を ℤ_{≥0} に広げた。Lean の具体版は Fin 0 の上の和（空の和）を使っていたが、本文の定義は m ≥ 1 しか定めていなかった。既存の証明が引く Σ_{j=1}^{1} z_j := z_1 と m ≥ 1 の帰納の式は変えていない。",
      ],
    },
  },

  {
    id: "calc_formulae_008d_definition_finite_sum_of_complex_numbers_from_index_zero",
    kind: "definition",
    title: { text: "添字が 0 から始まる複素数の有限和" },
    labels: ["def_finite_sum_of_complex_numbers_from_index_zero"],
    statement: [
      paragraph([
        math(String.raw`K \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`z_0,\dots,z_K \in \mathbb{C}`),
        " について、有限和 ",
        math(String.raw`\sum_{k=0}^{K} z_k \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\sum_{k=0}^{K} z_k := \sum_{j=1}^{K+1} z_{j-1}`),
      paragraph([
        "と定める。右辺は ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和（",
        math(String.raw`m \to K+1`),
        "、",
        math(String.raw`j`),
        " 番目の項を ",
        math(String.raw`z_{j-1}`),
        " とする）である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 3・Step 3' の部分和 Σ_{k=0}^{K} は添字が 0 から始まり、" +
          "def_finite_sum_of_complex_numbers（添字 1..m）が覆わなかったので、その和へ添字をずらして定めた。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_complex_zeros",
    kind: "claim",
    title: { text: "複素数の零の有限和は零" },
    labels: ["finite_sum_of_complex_zeros"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`\sum_{j=1}^{m} 0_{\mathbb{C}} = 0_{\mathbb{C}}`),
        " が成り立つ。有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        "、",
        math(String.raw`0_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} 0_{\mathbb{C}}
&= 0_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} 0_{\mathbb{C}}
&= \Bigl(\sum_{j=1}^{m} 0_{\mathbb{C}}\Bigr) + 0_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= 0_{\mathbb{C}} + 0_{\mathbb{C}}
&&(\because\ \text{帰納法の仮定})\\
&= (0,0) + (0,0)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (0+0,\ 0+0)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (0,0)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。congruence_preserves_positive_definite の B'0 = 0 の証明が使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_finite_sum_of_real_numbers",
    kind: "definition",
    title: { text: "実数の有限和" },
    labels: ["def_finite_sum_of_real_numbers"],
    lean: ["Ising2D.finset_sum_fin_real_eq_finite_sum_of_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        "（添字の集合 ",
        math(String.raw`\{1,\dots,m\}`),
        "（",
        ref("def_index_set_from_one_to_n"),
        "）から ",
        math(String.raw`\mathbb{R}`),
        " への写像。",
        math(String.raw`m = 0`),
        " のときは添字の集合が空で、項を一つも持たない）について、有限和 ",
        math(String.raw`\sum_{j=1}^{m} r_j \in \mathbb{R}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{j=1}^{0} r_j := 0,
\qquad
\sum_{j=1}^{1} r_j := r_1,
\qquad
\sum_{j=1}^{m+1} r_j := \Bigl(\sum_{j=1}^{m} r_j\Bigr) + r_{m+1}\quad (m \in \mathbb{Z}_{\geq 1})`),
      paragraph([
        "と定める（左から順に足す。",
        ref("def_finite_sum_of_complex_numbers"),
        " と同じ帰納法である）。和は ",
        math(String.raw`\mathbb{R}`),
        " の和、",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{R}`),
        " の零である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。real_inclusion_preserves_finite_sum と max_eigenvalue_of_V_plus_simple (2) の ǧ の差の鎖が ℝ の有限和を名前だけで使っていたので、引けるよう足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の二単位目）: def_finite_sum_of_complex_numbers と同じく、項の無い族の和 Σ_{j=1}^{0} r_j := 0 を足し、m の範囲を ℤ_{≥0} に広げた。既存の証明が引く Σ_{j=1}^{1} r_j := r_1 と m ≥ 1 の帰納の式は変えていない。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_constant_real_number",
    kind: "claim",
    title: { tex: String.raw`\sum_{j=1}^{m} r = \iota_{\mathbb{Z}\to\mathbb{R}}(m)\, r` },
    labels: ["finite_sum_of_constant_real_number"],
    lean: ["Ising2D.finite_sum_of_constant_real_number", "Ising2D.finite_sum_of_constant_real_number_succ"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " について、すべての項が ",
        math(String.raw`r`),
        " の有限和（",
        ref("def_finite_sum_of_real_numbers"),
        " の ",
        math(String.raw`r_1 = \dots = r_m = r`),
        "）は",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} r = \iota_{\mathbb{Z}\to\mathbb{R}}(m)\, r`),
      paragraph([
        "である。",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " は ",
        ref("inclusion_zz_to_rr"),
        " の写像、右辺の積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} r
&= 0
  &&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to r)\bigr)\\
&= 0_{\mathbb{R}}\, r
  &&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x \to r)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}})\, r
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(0_{\mathbb{Z}}) := 0_{\mathbb{R}}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} r
&= r
  &&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{1} r_j := r_1\ (r_1 \to r)\bigr)\\
&= 1_{\mathbb{R}}\, r
  &&\bigl(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})\, r
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_one}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} r
&= \Bigl(\sum_{j=1}^{m} r\Bigr) + r
  &&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{m+1} r_j := \bigl(\sum_{j=1}^{m} r_j\bigr) + r_{m+1}\ (r_j \to r)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(m)\, r + r
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(m)\, r + 1_{\mathbb{R}}\, r
  &&\bigl(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\bigr)\\
&= \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(m) + 1_{\mathbb{R}}\bigr)\, r
  &&\bigl(\because\ \mathbb{R}\ \text{の分配律}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(m +_{\mathbb{Z}} 1_{\mathbb{Z}})\, r
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ (n \to m)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`m+1`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_power_upper_bound の最後の鎖の「同じ項 c^n を d 個足した和」を引けるよう足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式・real_zero_times_is_zero・ι(0_ℤ) := 0_ℝ）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean は m ∈ ℤ_{≥0} の版 finite_sum_of_constant_real_number を欄 lean の先頭に置いた（有限型の添字の版は、使う側の人手が m → d ∈ ℤ_{≥1} で引くので 1 ≤ card κ の仮定のまま）。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_numbers_with_single_nonzero_term",
    kind: "claim",
    title: { text: "一つの項のほかが 0 の実数の有限和はその項に等しい" },
    labels: ["finite_sum_of_real_numbers_with_single_nonzero_term"],
    lean: ["Ising2D.finite_sum_of_real_numbers_with_single_nonzero_term_succ"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        "、",
        math(String.raw`k \in \{1,\dots,m\}`),
        " とし、",
        math(String.raw`j \neq k`),
        " のすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " について ",
        math(String.raw`r_j = 0`),
        " とする（",
        math(String.raw`0`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の 0）。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} r_j = r_k`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す（各 ",
        math(String.raw`m`),
        " で、仮定を満たすすべての ",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " と ",
        math(String.raw`k \in \{1,\dots,m\}`),
        " についての主張を示す）。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`k = 1`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} r_j
&= r_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{1} r_j := r_1\bigr)\\
&= r_k
&&(\because\ k = 1)
\end{aligned}`),
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " で成り立つと仮定し、",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " が仮定を満たすとする。",
        math(String.raw`k = m+1`),
        " のとき、",
        math(String.raw`j \in \{2,\dots,m\}`),
        " はどれも ",
        math(String.raw`j \neq k`),
        " なので ",
        math(String.raw`r_j = 0`),
        " であり、",
        math(String.raw`r_1,\dots,r_m`),
        " と ",
        math(String.raw`1 \in \{1,\dots,m\}`),
        " は帰納法の仮定の仮定を満たし、",
        math(String.raw`1 \neq m+1 = k`),
        " なので ",
        math(String.raw`r_1 = 0`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} r_j
&= \Bigl(\sum_{j=1}^{m} r_j\Bigr) + r_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{m+1} r_j := \bigl(\sum_{j=1}^{m} r_j\bigr) + r_{m+1}\bigr)\\
&= r_1 + r_{m+1}
&&(\because\ \text{帰納法の仮定を}\ r_1,\dots,r_m\ \text{と}\ k \to 1\ \text{へ})\\
&= 0 + r_{m+1}
&&(\because\ r_1 = 0)\\
&= r_{m+1}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= r_k
&&(\because\ k = m+1)
\end{aligned}`),
      paragraph([
        math(String.raw`k \in \{1,\dots,m\}`),
        " のとき、",
        math(String.raw`j \in \{1,\dots,m\}`),
        " かつ ",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`r_j = 0`),
        " なので ",
        math(String.raw`r_1,\dots,r_m`),
        " と ",
        math(String.raw`k`),
        " は帰納法の仮定の仮定を満たし、",
        math(String.raw`m+1 \neq k`),
        " なので ",
        math(String.raw`r_{m+1} = 0`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} r_j
&= \Bigl(\sum_{j=1}^{m} r_j\Bigr) + r_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{m+1} r_j := \bigl(\sum_{j=1}^{m} r_j\bigr) + r_{m+1}\bigr)\\
&= r_k + r_{m+1}
&&(\because\ \text{帰納法の仮定を}\ r_1,\dots,r_m\ \text{と}\ k\ \text{へ})\\
&= r_k + 0
&&(\because\ r_{m+1} = 0)\\
&= r_k
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`m+1`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-16（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。matrix_norm_vector_bound の ‖AW‖ と ‖W‖ の鎖の「第 2 列以降は平方和に寄与しない」（ℝ の有限和で 0 の項を落とす）を引けるよう足した。複素数版 finite_sum_with_single_nonzero_term と違い、k = m+1 の場合は零の有限和を経ず、帰納法の仮定を k → 1 へ当てて残りの項を r_1 = 0 にまとめる（ℝ の零の有限和には専用の主張が無く、finite_sum_of_constant_real_number と real_times_zero_is_zero の 2 行で示すと乗法を経るが、この形なら 0 が和の単位元であることだけで済むため）。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_finite_sum",
    kind: "claim",
    title: { text: "実数の有限和の包含は包含の有限和に等しい" },
    labels: ["real_inclusion_preserves_finite_sum"],
    lean: ["Ising2D.real_inclusion_of_finite_sum", "Ising2D.real_inclusion_of_finite_sum_succ", "Ising2D.real_inclusion_of_finite_sum_fintype", "Ising2D.real_inclusion_of_finite_sum_fintype_or_empty"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (r_j)_{\mathbb{C}} = \Bigl(\sum_{j=1}^{m} r_j\Bigr)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の和は ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和、右辺の和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} (r_j)_{\mathbb{C}}
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} z_j := 0_{\mathbb{C}}\ (z_j \to (r_j)_{\mathbb{C}})\bigr)\\
&= (0_{\mathbb{R}})_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 0_{\mathbb{C}} := (0_{\mathbb{R}})_{\mathbb{C}}\bigr)\\
&= \Bigl(\sum_{j=1}^{0} r_j\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (r_j)_{\mathbb{C}}
&= (r_1)_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \Bigl(\sum_{j=1}^{1} r_j\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_real_numbers})
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " で成り立つと仮定する。",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (r_j)_{\mathbb{C}}
&= \Bigl(\sum_{j=1}^{m} (r_j)_{\mathbb{C}}\Bigr) + (r_{m+1})_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \Bigl(\sum_{j=1}^{m} r_j\Bigr)_{\mathbb{C}} + (r_{m+1})_{\mathbb{C}}
&&(\because\ \text{帰納法の仮定})\\
&= \Bigl(\sum_{j=1}^{m} r_j,\ 0\Bigr) + (r_{m+1},\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{を各項へ})\\
&= \Bigl(\sum_{j=1}^{m} r_j + r_{m+1},\ 0 + 0\Bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= \Bigl(\sum_{j=1}^{m+1} r_j,\ 0 + 0\Bigr)
&&(\because\ \blkref{def_finite_sum_of_real_numbers})\\
&= \Bigl(\sum_{j=1}^{m+1} r_j,\ 0\Bigr)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= \Bigl(\sum_{j=1}^{m+1} r_j\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。正定値性の主張（identity_matrix_is_positive_definite、trace_of_positive_definite_is_positive）が、ℂ の元が正の実数の包含であることを示すのに使うので足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目の (a) の残り）: def_finite_sum_of_real_numbers・def_finite_sum_of_complex_numbers が項の無い族の和 Σ_{j=1}^{0} := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の 3 行（ℂ の空の和の式・inclusion_rr_to_cc の 0_ℂ := (0_ℝ)_ℂ・ℝ の空の和の式を右辺から左辺へ）を足した。Lean は添字の型が空でもよい有限型の和（real_inclusion_of_finite_sum_fintype_or_empty・real_inclusion_of_finite_sum_finset）から引かれており、空の場合を本文の外の Lean だけの場合として扱っていた。具体版の主は Fin m の版 Ising2D.real_inclusion_of_finite_sum。数値検証: sagemath/check/real_inclusion_preserves_finite_sum/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_sum",
    kind: "claim",
    title: { text: "実数の和の包含は包含の和に等しい" },
    labels: ["real_inclusion_preserves_sum"],
    lean: ["Ising2D.real_inclusion_add"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`a_{\mathbb{C}} + b_{\mathbb{C}} = (a + b)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の和は ",
        ref("definition_of_cc"),
        " の和、右辺の和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a_{\mathbb{C}} + b_{\mathbb{C}}
&= (a,\ 0) + (b,\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{を 2 か所へ同時適用})\\
&= (a + b,\ 0 + 0)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (a + b,\ 0)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= (a + b)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。real_inclusion_preserves_sum_over_binary_words の帰納法の各段が二つの実数の和の包含を使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_differences",
    kind: "claim",
    title: { text: "実数の差の有限和は有限和の差" },
    labels: ["finite_sum_of_real_differences"],
    lean: ["Ising2D.finite_sum_of_real_differences", "Ising2D.finite_sum_of_real_differences_succ", "Ising2D.finite_sum_of_real_differences_step"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`a_1,\dots,a_m, b_1,\dots,b_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (a_j - b_j) = \Bigl(\sum_{j=1}^{m} a_j\Bigr) - \Bigl(\sum_{j=1}^{m} b_j\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} (a_j - b_j)
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j - b_j)\bigr)\\
&= 0 - 0
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to 0)\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\sum_{j=1}^{0} a_j\Bigr) - \Bigl(\sum_{j=1}^{0} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (a_j - b_j)
&= a_1 - b_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j - b_j)\bigr)\\
&= \Bigl(\sum_{j=1}^{1} a_j\Bigr) - \Bigl(\sum_{j=1}^{1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1}, b_1,\dots,b_{m+1} \in \mathbb{R}`),
        " を取る。",
        math(String.raw`\alpha := \sum_{j=1}^{m} a_j`),
        "、",
        math(String.raw`\beta := \sum_{j=1}^{m} b_j`),
        " とおく（",
        math(String.raw`\alpha, \beta \in \mathbb{R}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (a_j - b_j)
&= \Bigl(\sum_{j=1}^{m} (a_j - b_j)\Bigr) + (a_{m+1} - b_{m+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j - b_j)\bigr)\\
&= (\alpha - \beta) + (a_{m+1} - b_{m+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \bigl(\alpha + (-\beta)\bigr) + \bigl(a_{m+1} + (-b_{m+1})\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \alpha,\ z \to \beta;\ y \to a_{m+1},\ z \to b_{m+1})\ \text{を 2 か所へ同時適用}\bigr)\\
&= \alpha + \Bigl((-\beta) + \bigl(a_{m+1} + (-b_{m+1})\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to \alpha,\ q \to -\beta,\ s \to a_{m+1} + (-b_{m+1}))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \alpha + \Bigl(\bigl((-\beta) + a_{m+1}\bigr) + (-b_{m+1})\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to -\beta,\ q \to a_{m+1},\ s \to -b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \alpha + \Bigl(\bigl(a_{m+1} + (-\beta)\bigr) + (-b_{m+1})\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の交換律}\ p + q = q + p\ (p \to -\beta,\ q \to a_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \alpha + \Bigl(a_{m+1} + \bigl((-\beta) + (-b_{m+1})\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to a_{m+1},\ q \to -\beta,\ s \to -b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (\alpha + a_{m+1}) + \bigl((-\beta) + (-b_{m+1})\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to \alpha,\ q \to a_{m+1},\ s \to (-\beta) + (-b_{m+1}))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= (\alpha + a_{m+1}) + \bigl(-(\beta + b_{m+1})\bigr)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ (x \to \beta,\ y \to b_{m+1})\ \text{を右辺から左辺へ}\bigr)\\
&= (\alpha + a_{m+1}) - (\beta + b_{m+1})
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \alpha + a_{m+1},\ z \to \beta + b_{m+1})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}\Bigr) - \Bigl(\Bigl(\sum_{j=1}^{m} b_j\Bigr) + b_{m+1}\Bigr)
&&\bigl(\because\ \alpha, \beta\ \text{の置き方}\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} a_j\Bigr) - \Bigl(\sum_{j=1}^{m+1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。max_eigenvalue_of_V_plus_simple (2) の ǧ(1,…,1) − ǧ(ε) の鎖が「ǧ の定義と分配法則」の名前だけで二つの有限和の差を項ごとの差の有限和にしていたので、引けるよう足した。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w7)。和と差の計算の行を割る件）: 帰納法の段の 1 行「ℝ の和と差の計算」（(α − β) + (a − b) = (α + a) − (β + b)）が複数の法則をまとめていたので、def_real_difference の 2 か所同時適用・加法の結合則・結合則・交換則・結合則・結合則（finite_sum_of_real_sums の帰納法の段と同じ 5 行）・real_negation_of_sum_is_sum_of_negations（右辺から左辺へ）・def_real_difference（右辺から左辺へ）の 8 行に割った（鎖の両端と主張は不変）。Lean の Ising2D.finite_sum_of_real_differences_step は同じ 8 段の calc。数値検証: sagemath/check/finite_sum_of_real_differences/。",
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w14)。有限和の定義の代入と、結合則・交換則の形を揃える件）: m = 1 の 2 行と帰納法の段の最初と最後の行の def_finite_sum_of_real_numbers に代入（r_j → a_j − b_j、r_j → a_j; r_j → b_j）と向き（右辺から左辺へ）を書き、帰納法の段の加法の結合則・交換則の 5 行を形 (p + q) + s = p + (q + s)・p + q = q + p と代入を添えた set_and_algebra_notation の参照にした（兄弟の finite_sum_of_real_sums と揃えた。文字 p, q, s は同じ鎖の def_finite_sum_of_real_numbers の r_j、def_real_difference の y, z、real_negation_of_sum_is_sum_of_negations の x, y と衝突しないよう選んだ。def_finite_sum_of_real_numbers の 2 か所同時適用の代入は「;」で区切った。主張・鎖・段数は不変）。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_sums",
    kind: "claim",
    title: { text: "実数の和の有限和は有限和の和" },
    labels: ["finite_sum_of_real_sums"],
    lean: ["Ising2D.finite_sum_of_real_sums", "Ising2D.finite_sum_of_real_sums_succ", "Ising2D.finite_sum_of_real_sums_step", "Ising2D.finite_sum_of_real_sums_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`a_1,\dots,a_m, b_1,\dots,b_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (a_j + b_j) = \Bigl(\sum_{j=1}^{m} a_j\Bigr) + \Bigl(\sum_{j=1}^{m} b_j\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} (a_j + b_j)
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j + b_j)\bigr)\\
&= 0 + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \Bigl(\sum_{j=1}^{0} a_j\Bigr) + \Bigl(\sum_{j=1}^{0} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (a_j + b_j)
&= a_1 + b_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j + b_j)\bigr)\\
&= \Bigl(\sum_{j=1}^{1} a_j\Bigr) + \Bigl(\sum_{j=1}^{1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1}, b_1,\dots,b_{m+1} \in \mathbb{R}`),
        " を取る。",
        math(String.raw`\alpha := \sum_{j=1}^{m} a_j`),
        "、",
        math(String.raw`\beta := \sum_{j=1}^{m} b_j`),
        " とおく（",
        math(String.raw`\alpha, \beta \in \mathbb{R}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (a_j + b_j)
&= \Bigl(\sum_{j=1}^{m} (a_j + b_j)\Bigr) + (a_{m+1} + b_{m+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j + b_j)\bigr)\\
&= (\alpha + \beta) + (a_{m+1} + b_{m+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \alpha + \bigl(\beta + (a_{m+1} + b_{m+1})\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to \alpha,\ q \to \beta,\ s \to a_{m+1} + b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \alpha + \bigl((\beta + a_{m+1}) + b_{m+1}\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to \beta,\ q \to a_{m+1},\ s \to b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \alpha + \bigl((a_{m+1} + \beta) + b_{m+1}\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の交換律}\ p + q = q + p\ (p \to \beta,\ q \to a_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \alpha + \bigl(a_{m+1} + (\beta + b_{m+1})\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to a_{m+1},\ q \to \beta,\ s \to b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (\alpha + a_{m+1}) + (\beta + b_{m+1})
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (p + q) + s = p + (q + s)\ (p \to \alpha,\ q \to a_{m+1},\ s \to \beta + b_{m+1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}\Bigr) + \Bigl(\Bigl(\sum_{j=1}^{m} b_j\Bigr) + b_{m+1}\Bigr)
&&\bigl(\because\ \alpha, \beta\ \text{の置き方}\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} a_j\Bigr) + \Bigl(\sum_{j=1}^{m+1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to a_j;\ r_j \to b_j)\ \text{を右辺から左辺へ 2 か所同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直すとき、実数の双線型値 (a+b)^⊤P(a+b) を 4 項へ展開する段（def_real_bilinear_value の二重の有限和を項ごとの和の有限和から二つの有限和へ分ける）から引けるよう足した。psd_cauchy_schwarz の q(t) の展開も同じ段を「有限和の項の並べ替え」の名前だけで使っている。複素数の兄弟の主張 finite_sum_of_complex_sums と同じ帰納法で、和の結合則・交換則の適用を 1 段ずつに割った。数値検証: sagemath/check/finite_sum_of_real_sums/。",
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w14)。有限和の定義の代入と、結合則・交換則の形を揃える件）: 帰納法の段の加法の結合則・交換則の 5 行を、形 (p + q) + s = p + (q + s)・p + q = q + p と代入を添えた set_and_algebra_notation の参照にした（finite_sum_of_real_differences と揃えた。m = 1 の 2 行目と帰納法の段の最後の行の def_finite_sum_of_real_numbers の 2 か所同時適用の代入の区切りを「,」から「;」にし、「を右辺から左辺へ 2 か所へ同時適用」の「へ」の重なりを「を右辺から左辺へ 2 か所同時適用」にした。主張・鎖・段数は不変）。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_zeros",
    kind: "claim",
    title: { text: "実数の零の有限和は零" },
    labels: ["finite_sum_of_real_zeros"],
    lean: ["Ising2D.finite_sum_of_real_zeros", "Ising2D.finite_sum_of_real_zeros_succ"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について、すべての項が ",
        math(String.raw`0 \in \mathbb{R}`),
        " の有限和（",
        ref("def_finite_sum_of_real_numbers"),
        " の ",
        math(String.raw`r_1 = \dots = r_m = 0`),
        "）は",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} 0 = 0`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} 0
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to 0)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} 0
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{1} r_j := r_1\ (r_1 \to 0)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " で主張が成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} 0
&= \Bigl(\sum_{j=1}^{m} 0\Bigr) + 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{m+1} r_j := \bigl(\sum_{j=1}^{m} r_j\bigr) + r_{m+1}\ (r_j \to 0)\bigr)\\
&= 0 + 0
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`m+1`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: 原文（Typst）に対応ブロックは無い。finite_double_sum_of_real_numbers_interchange を n_1 = 0 へ広げたとき、その鎖の「Σ_{l=1}^{n_2} 0 = 0」を引けるよう足した（finite_sum_of_constant_real_number と real_times_zero_is_zero の 2 行で示すと実数の乗法を通り、主張に効かない構造を持ち込むため）。複素数の兄弟は finite_sum_of_complex_zeros。数値検証: sagemath/check/finite_sum_of_real_zeros/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_double_sum_of_real_numbers_interchange",
    kind: "claim",
    title: { text: "実数の二重の有限和は和の順序を入れ替えても等しい" },
    labels: ["finite_double_sum_of_real_numbers_interchange"],
    lean: ["Ising2D.finite_double_sum_of_real_numbers_interchange", "Ising2D.finite_double_sum_of_real_numbers_interchange_succ", "Ising2D.finite_double_sum_of_real_numbers_interchange_fintype"],
    statement: [
      paragraph([
        math(String.raw`n_1, n_2 \in \mathbb{Z}_{\geq 0}`),
        " とし、",
        math(String.raw`k \in \{1,\dots,n_1\}`),
        "、",
        math(String.raw`l \in \{1,\dots,n_2\}`),
        " について ",
        math(String.raw`c_{k,l} \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による（内側の和 ",
        math(String.raw`\sum_{l=1}^{n_2} c_{k,l}`),
        "・",
        math(String.raw`\sum_{k=1}^{n_1} c_{k,l}`),
        " も ",
        math(String.raw`\mathbb{R}`),
        " の元で、外側の和はその有限和である）。このとき",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n_1}\sum_{l=1}^{n_2} c_{k,l} = \sum_{l=1}^{n_2}\sum_{k=1}^{n_1} c_{k,l}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n_1 = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{0}\sum_{l=1}^{n_2} c_{k,l}
&= 0
&&\Bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ \Bigl(r_j \to \sum_{l=1}^{n_2} c_{j,l}\Bigr)\Bigr)\\
&= \sum_{l=1}^{n_2} 0
&&\bigl(\because\ \blkref{finite_sum_of_real_zeros}\ (m \to n_2)\ \text{を右辺から左辺へ}\bigr)\\
&= \sum_{l=1}^{n_2}\sum_{k=1}^{0} c_{k,l}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to c_{j,l})\ \text{を右辺から左辺へ、各}\ l\ \text{の項へ同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n_1 \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`n_1`),
        " についての帰納法で示す（",
        math(String.raw`n_2`),
        " は固定する）。",
        math(String.raw`n_1 = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{1}\sum_{l=1}^{n_2} c_{k,l}
&= \sum_{l=1}^{n_2} c_{1,l}
&&\Bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \Bigl(r_j \to \sum_{l=1}^{n_2} c_{j,l}\Bigr)\Bigr)\\
&= \sum_{l=1}^{n_2}\sum_{k=1}^{1} c_{k,l}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to c_{j,l})\ \text{を右辺から左辺へ、各}\ l\ \text{の項へ同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n_1`),
        " で成り立つと仮定し、",
        math(String.raw`k \in \{1,\dots,n_1+1\}`),
        "、",
        math(String.raw`l \in \{1,\dots,n_2\}`),
        " について ",
        math(String.raw`c_{k,l} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n_1+1}\sum_{l=1}^{n_2} c_{k,l}
&= \Bigl(\sum_{k=1}^{n_1}\sum_{l=1}^{n_2} c_{k,l}\Bigr) + \sum_{l=1}^{n_2} c_{n_1+1,l}
&&\Bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \Bigl(m \to n_1,\ r_j \to \sum_{l=1}^{n_2} c_{j,l}\Bigr)\Bigr)\\
&= \Bigl(\sum_{l=1}^{n_2}\sum_{k=1}^{n_1} c_{k,l}\Bigr) + \sum_{l=1}^{n_2} c_{n_1+1,l}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{l=1}^{n_2}\Bigl(\Bigl(\sum_{k=1}^{n_1} c_{k,l}\Bigr) + c_{n_1+1,l}\Bigr)
&&\Bigl(\because\ \blkref{finite_sum_of_real_sums}\ \Bigl(m \to n_2,\ a_j \to \sum_{k=1}^{n_1} c_{k,j},\ b_j \to c_{n_1+1,j}\Bigr)\ \text{を右辺から左辺へ}\Bigr)\\
&= \sum_{l=1}^{n_2}\sum_{k=1}^{n_1+1} c_{k,l}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (m \to n_1,\ r_j \to c_{j,l})\ \text{を右辺から左辺へ、各}\ l\ \text{の項へ同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。psd_cauchy_schwarz の準備の鎖が実数の二重の有限和の順序を「ℝ の加法の結合則・可換則による有限和の順序の入れ替え」と名前だけで入れ替えていたので、その段を引けるよう足した。c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直すときの双線型値の対称性の段も同じ入れ替えを使う。外側の和の項の数 n_1 についての帰納法で、帰納法の段は finite_sum_of_real_sums を引く。数値検証: sagemath/check/finite_double_sum_of_real_numbers_interchange/。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の n_1, n_2 の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げた。n_1 = 0 の鎖（空の和の式・この回に足した finite_sum_of_real_zeros・空の和の式を各項へ）を足した。n_1 ≥ 1 の帰納法の鎖は変えていない（n_2 = 0 でも、引く finite_sum_of_real_sums が m ∈ ℤ_{≥0} の主張なのでそのまま通る）。Lean は p = 0 の段を人手の 3 行と 1 対 1 の calc にし、_succ の内側の項の数を q（0 を含む）にした。数値検証に n_1 = 0・n_2 = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_negated_real_numbers",
    kind: "claim",
    title: { text: "実数の符号反転の有限和は有限和の符号反転" },
    labels: ["finite_sum_of_negated_real_numbers"],
    lean: ["Ising2D.finite_sum_of_negated_real_numbers", "Ising2D.finite_sum_of_negated_real_numbers_succ"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (-x_j) = -\sum_{j=1}^{m} x_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} (-x_j)
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to -x_j)\bigr)\\
&= -0
&&\bigl(\because\ \blkref{real_negation_of_zero_is_zero}\ \text{を右辺から左辺へ}\bigr)\\
&= -\sum_{j=1}^{0} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to x_j)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (-x_j)
&= -x_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to -x_j)\bigr)\\
&= -\sum_{j=1}^{1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`x_1,\dots,x_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (-x_j)
&= \Bigl(\sum_{j=1}^{m} (-x_j)\Bigr) + (-x_{m+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to -x_j)\bigr)\\
&= \Bigl(-\sum_{j=1}^{m} x_j\Bigr) + (-x_{m+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= -\Bigl(\Bigl(\sum_{j=1}^{m} x_j\Bigr) + x_{m+1}\Bigr)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ \text{を文字を}\ p, q\ \text{に替えた}\ -(p+q) = (-p)+(-q)\ \bigl(p \to \textstyle\sum_{j=1}^{m} x_j,\ q \to x_{m+1}\bigr)\ \text{を右辺から左辺へ}\bigr)\\
&= -\sum_{j=1}^{m+1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 3 が −ǧ(ε) = −Σ_μ γ(θ̃_μ)(ε_μ − 1/2) の符号反転を有限和の各項へ入れるのに引くので足した（それまでは「Step 2 を γ → −γ として適用」と名前だけで根拠にしていた）。Lean は Ising2D.finite_sum_of_negated_real_numbers（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean）。数値検証: sagemath/check/finite_sum_of_negated_real_numbers/。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 帰納法の段の根拠「ℝ で (−a)+(−b) = −(a+b)」を、この回に足した主張 real_negation_of_sum_is_sum_of_negations（文字を p, q に替え p → Σ_{j=1}^{m} x_j, q → x_{m+1}）を右辺から左辺へ当てる参照にした（文書の並びでは後ろのファイルのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_scalar_multiples",
    kind: "claim",
    title: { text: "実数の共通の因子は有限和の外へ出せる" },
    labels: ["finite_sum_of_real_scalar_multiples"],
    lean: ["Ising2D.finite_sum_of_real_scalar_multiples", "Ising2D.finite_sum_of_real_scalar_multiples_succ", "Ising2D.finite_sum_of_real_scalar_multiples_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`c \in \mathbb{R}`),
        "、",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} c\,x_j = c\sum_{j=1}^{m} x_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} c\,x_j
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to c\,x_j)\bigr)\\
&= c \cdot 0
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x \to c)\ \text{を右辺から左辺へ}\bigr)\\
&= c\sum_{j=1}^{0} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to x_j)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} c\,x_j
&= c\,x_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to c\,x_j)\bigr)\\
&= c\sum_{j=1}^{1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`x_1,\dots,x_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} c\,x_j
&= \Bigl(\sum_{j=1}^{m} c\,x_j\Bigr) + c\,x_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to c\,x_j)\bigr)\\
&= c\Bigl(\sum_{j=1}^{m} x_j\Bigr) + c\,x_{m+1}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= c\Bigl(\Bigl(\sum_{j=1}^{m} x_j\Bigr) + x_{m+1}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ ca + cb = c(a + b)\ \bigl(a \to \textstyle\sum_{j=1}^{m} x_j,\ b \to x_{m+1}\bigr)\bigr)\\
&= c\sum_{j=1}^{m+1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。eigenvalues_of_V_plus (2) の ǧ(1,…,1) = ½Σγ(θ~_μ)・ǧ(0,…,0) = −½Σγ(θ~_μ) の鎖が、共通の因子 ½・−½ を有限和の外へ出すのに引くので足した。Lean は Ising2D.finite_sum_of_real_scalar_multiples（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean）、必要十分版は Ising2D.NecSuf.finite_sum_mul_left_fin'。数値検証: sagemath/check/finite_sum_of_real_scalar_multiples/。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term",
    kind: "claim",
    title: { text: "非負の実数の有限和は各項以上" },
    labels: ["finite_sum_of_nonnegative_reals_is_at_least_each_term"],
    lean: ["Ising2D.finite_sum_of_nonnegative_reals_ge_term_succ", "Ising2D.finite_sum_of_nonnegative_reals_ge_term", "Ising2D.finite_sum_of_nonnegative_reals_ge_term_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_m \in \mathbb{R}`),
        " がすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`a_j \geq 0`),
        " を満たすとする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき、すべての ",
        math(String.raw`k \in \{1,\dots,m\}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} a_j \geq a_k`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す（各 ",
        math(String.raw`m`),
        " で、すべての ",
        math(String.raw`k \in \{1,\dots,m\}`),
        " についての主張を示す）。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`k = 1`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} a_j
&= a_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= a_k
&&\bigl(\because\ k = 1\bigr)
\end{aligned}`),
      paragraph([
        "だから ",
        math(String.raw`\sum_{j=1}^{1} a_j \geq a_k`),
        " である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1} \in \mathbb{R}`),
        " がすべて ",
        math(String.raw`0`),
        " 以上であるとして、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " を取る。",
        math(String.raw`k \leq m`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_j
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\geq \Bigl(\sum_{j=1}^{m} a_j\Bigr) + 0
&&\bigl(\because\ a_{m+1} \geq 0\ \text{の両辺に同じ実数を足す}\bigr)\\
&= \sum_{j=1}^{m} a_j
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&\geq a_k
&&\bigl(\because\ \text{帰納法の仮定（}k \leq m\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k = m+1`),
        " のとき、",
        math(String.raw`a_1,\dots,a_m`),
        " はすべて ",
        math(String.raw`0`),
        " 以上であり、",
        math(String.raw`m \geq 1`),
        " なので ",
        math(String.raw`1 \in \{1,\dots,m\}`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m} a_j
&\geq a_1
&&\bigl(\because\ \text{帰納法の仮定（}a_1,\dots,a_m\text{ について、}k \to 1\text{）}\bigr)\\
&\geq 0
&&\bigl(\because\ \text{仮定 }a_1 \geq 0\bigr)
\end{aligned}`),
      paragraph([
        "であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_j
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\geq 0 + a_{m+1}
&&\bigl(\because\ \textstyle\sum_{j=1}^{m} a_j \geq 0\ \text{の両辺に同じ実数を足す}\bigr)\\
&= a_{m+1}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= a_k
&&\bigl(\because\ k = m+1\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。max_eigenvalue_of_V_plus_simple (2) の ǧ(1,…,1) − ǧ(ε) の鎖が「各項は 0 以上。μ = μ_0 の項だけを残す」の名前だけで有限和を一つの項で下から抑えていたので、引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_index_skipping_map",
    kind: "definition",
    title: { text: "一つの添字を飛ばす写像" },
    labels: ["def_index_skipping_map"],
    lean: ["Ising2D.skipIndex"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " について、写像 ",
        math(String.raw`\delta^{m}_{k} : \{1,\dots,m\} \to \{1,\dots,m+1\}`),
        " を",
      ]),
      displayMath(String.raw`\delta^{m}_{k}(j) :=
\begin{cases}
  j & (j < k) \\
  j + 1 & (j \geq k)
\end{cases}`),
      paragraph([
        "と定める（",
        math(String.raw`\{1,\dots,m+1\}`),
        " から ",
        math(String.raw`k`),
        " だけを飛ばす。",
        math(String.raw`1,\dots,m`),
        " を、小さい順を保って ",
        math(String.raw`\{1,\dots,m+1\}`),
        " から ",
        math(String.raw`k`),
        " を除いた集合へ送る写像である）。値は ",
        math(String.raw`\{1,\dots,m+1\}`),
        " に入る: ",
        math(String.raw`j < k`),
        " のとき ",
        math(String.raw`1 \leq j \leq m`),
        "、",
        math(String.raw`j \geq k`),
        " のとき ",
        math(String.raw`2 \leq j + 1 \leq m + 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを示す準備として、有限和の一つの項を末尾へ移す主張 finite_sum_of_real_numbers_moves_one_term_to_end が、残りの項の添字の付け方に使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_numbers_moves_one_term_to_end",
    kind: "claim",
    title: { text: "実数の有限和の一つの項は末尾へ移せる" },
    labels: ["finite_sum_of_real_numbers_moves_one_term_to_end"],
    lean: ["Ising2D.finite_sum_of_real_numbers_moves_one_term_to_end"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`b_1,\dots,b_{m+1} \in \mathbb{R}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        "、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m+1} b_j = \Bigl(\sum_{j=1}^{m} b_{\delta^{m}_{k}(j)}\Bigr) + b_k`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す（各 ",
        math(String.raw`m`),
        " で、すべての ",
        math(String.raw`b_1,\dots,b_{m+1} \in \mathbb{R}`),
        " と ",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " についての主張を示す）。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`k \in \{1, 2\}`),
        " である。",
        math(String.raw`k = 1`),
        " のとき、",
        math(String.raw`1 \geq 1`),
        " なので ",
        ref("def_index_skipping_map"),
        " より ",
        math(String.raw`\delta^{1}_{1}(1) = 2`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{2} b_j
&= \Bigl(\sum_{j=1}^{1} b_j\Bigr) + b_2
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= b_1 + b_2
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= b_2 + b_1
&&\bigl(\because\ \mathbb{R}\ \text{の和の交換律}\bigr)\\
&= b_{\delta^{1}_{1}(1)} + b_1
&&\bigl(\because\ \delta^{1}_{1}(1) = 2\bigr)\\
&= \Bigl(\sum_{j=1}^{1} b_{\delta^{1}_{1}(j)}\Bigr) + b_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\sum_{j=1}^{1} b_{\delta^{1}_{k}(j)}\Bigr) + b_k
&&\bigl(\because\ k = 1\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k = 2`),
        " のとき、",
        math(String.raw`1 < 2`),
        " なので ",
        ref("def_index_skipping_map"),
        " より ",
        math(String.raw`\delta^{1}_{2}(1) = 1`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{2} b_j
&= \Bigl(\sum_{j=1}^{1} b_j\Bigr) + b_2
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= \Bigl(\sum_{j=1}^{1} b_{\delta^{1}_{2}(j)}\Bigr) + b_2
&&\bigl(\because\ \delta^{1}_{2}(1) = 1\bigr)\\
&= \Bigl(\sum_{j=1}^{1} b_{\delta^{1}_{k}(j)}\Bigr) + b_k
&&\bigl(\because\ k = 2\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`b_1,\dots,b_{m+2} \in \mathbb{R}`),
        " と ",
        math(String.raw`k \in \{1,\dots,m+2\}`),
        " を取る。",
        math(String.raw`k = m+2`),
        " のとき、すべての ",
        math(String.raw`j \in \{1,\dots,m+1\}`),
        " で ",
        math(String.raw`j < m+2`),
        " なので ",
        ref("def_index_skipping_map"),
        " より ",
        math(String.raw`\delta^{m+1}_{m+2}(j) = j`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+2} b_j
&= \Bigl(\sum_{j=1}^{m+1} b_j\Bigr) + b_{m+2}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} b_{\delta^{m+1}_{m+2}(j)}\Bigr) + b_{m+2}
&&\bigl(\because\ \delta^{m+1}_{m+2}(j) = j\ \text{を各項へ}\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} b_{\delta^{m+1}_{k}(j)}\Bigr) + b_k
&&\bigl(\because\ k = m+2\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k \leq m+1`),
        " のとき、",
        math(String.raw`j \in \{1,\dots,m\}`),
        " を取る。",
        math(String.raw`j < k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m+1}_{k}(j)
&= j
&&\bigl(\because\ \blkref{def_index_skipping_map}\ (m \to m+1),\ j < k\bigr)\\
&= \delta^{m}_{k}(j)
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j < k\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`j \geq k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m+1}_{k}(j)
&= j + 1
&&\bigl(\because\ \blkref{def_index_skipping_map}\ (m \to m+1),\ j \geq k\bigr)\\
&= \delta^{m}_{k}(j)
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j \geq k\bigr)
\end{aligned}`),
      paragraph([
        "である。よってすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`\delta^{m+1}_{k}(j) = \delta^{m}_{k}(j)`),
        " である。また ",
        math(String.raw`m+1 \geq k`),
        " なので ",
        ref("def_index_skipping_map"),
        " より ",
        math(String.raw`\delta^{m+1}_{k}(m+1) = m+2`),
        " である。",
        math(String.raw`s := \sum_{j=1}^{m} b_{\delta^{m}_{k}(j)}`),
        " とおく（",
        math(String.raw`s \in \mathbb{R}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+2} b_j
&= \Bigl(\sum_{j=1}^{m+1} b_j\Bigr) + b_{m+2}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} b_{\delta^{m}_{k}(j)}\Bigr) + b_k\Bigr) + b_{m+2}
&&\bigl(\because\ \text{帰納法の仮定（}b_1,\dots,b_{m+1}\ \text{と}\ k \in \{1,\dots,m+1\}\ \text{について）}\bigr)\\
&= (s + b_k) + b_{m+2}
&&\bigl(\because\ s\ \text{の置き方}\bigr)\\
&= s + (b_k + b_{m+2})
&&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= s + (b_{m+2} + b_k)
&&\bigl(\because\ \mathbb{R}\ \text{の和の交換律}\bigr)\\
&= (s + b_{m+2}) + b_k
&&\bigl(\because\ \mathbb{R}\ \text{の和の結合律}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} b_{\delta^{m}_{k}(j)}\Bigr) + b_{m+2}\Bigr) + b_k
&&\bigl(\because\ s\ \text{の置き方}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} b_{\delta^{m+1}_{k}(j)}\Bigr) + b_{m+2}\Bigr) + b_k
&&\bigl(\because\ j \in \{1,\dots,m\}\ \text{で}\ \delta^{m}_{k}(j) = \delta^{m+1}_{k}(j)\ \text{を各項へ}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} b_{\delta^{m+1}_{k}(j)}\Bigr) + b_{\delta^{m+1}_{k}(m+1)}\Bigr) + b_k
&&\bigl(\because\ \delta^{m+1}_{k}(m+1) = m+2\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} b_{\delta^{m+1}_{k}(j)}\Bigr) + b_k
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないこと（c_between_Lambda_half_and_twice_Lambda_half の Step 2 を ε_ℝ で書き直すときに ‖ε_ℝu‖ = ‖u‖ を示すのに要る）を帰納法で示す段で、π(k) = m+1 の項を末尾へ移すのに使うので足した。Lean は Ising2D.finite_sum_of_real_numbers_moves_one_term_to_end（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean）、必要十分版は Ising2D.NecSuf.finite_sum_skip_index_succ'（NecSuf/FiniteSumMovesOneTermToEnd.lean）。数値検証: sagemath/check/finite_sum_of_real_numbers_moves_one_term_to_end/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_index_skipping_map_never_takes_skipped_index",
    kind: "claim",
    title: { text: "一つの添字を飛ばす写像は飛ばした添字を値に取らない" },
    labels: ["index_skipping_map_never_takes_skipped_index"],
    lean: ["Ising2D.skipIndex_ne"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。このとき、すべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`\delta^{m}_{k}(j) \neq k`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j \in \{1,\dots,m\}`),
        " を取る。",
        math(String.raw`j < k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j)
&= j
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j < k\bigr)\\
&< k
&&\bigl(\because\ j < k\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`j \geq k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j)
&= j + 1
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j \geq k\bigr)\\
&> j
&&\bigl(\because\ 1 > 0\bigr)\\
&\geq k
&&\bigl(\because\ j \geq k\bigr)
\end{aligned}`),
      paragraph([
        "である。どちらの場合も ",
        math(String.raw`\delta^{m}_{k}(j) \neq k`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを示す準備として、bijection_composed_with_index_skipping_map_stays_in_lower_indices が使うので足した。Lean は Ising2D.skipIndex_ne（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimIndexSkippingMapProperties.lean）。数値検証: sagemath/check/index_skipping_map_never_takes_skipped_index/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_index_skipping_map_is_injective",
    kind: "claim",
    title: { text: "一つの添字を飛ばす写像は単射である" },
    labels: ["index_skipping_map_is_injective"],
    lean: ["Ising2D.skipIndex_injective"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。このとき、",
        math(String.raw`j, j' \in \{1,\dots,m\}`),
        " が ",
        math(String.raw`\delta^{m}_{k}(j) = \delta^{m}_{k}(j')`),
        " を満たすなら ",
        math(String.raw`j = j'`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j, j' \in \{1,\dots,m\}`),
        " が ",
        math(String.raw`\delta^{m}_{k}(j) = \delta^{m}_{k}(j')`),
        " を満たすとする。",
        math(String.raw`j < k`),
        " かつ ",
        math(String.raw`j' < k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
j
&= \delta^{m}_{k}(j)
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j < k\bigr)\\
&= \delta^{m}_{k}(j')
&&\bigl(\because\ \text{仮定}\bigr)\\
&= j'
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j' < k\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`j \geq k`),
        " かつ ",
        math(String.raw`j' \geq k`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
j
&= (j + 1) - 1
&&\bigl(\because\ 1 - 1 = 0\bigr)\\
&= \delta^{m}_{k}(j) - 1
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j \geq k\bigr)\\
&= \delta^{m}_{k}(j') - 1
&&\bigl(\because\ \text{仮定}\bigr)\\
&= (j' + 1) - 1
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j' \geq k\bigr)\\
&= j'
&&\bigl(\because\ 1 - 1 = 0\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`j < k \leq j'`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j)
&= j
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j < k\bigr)\\
&< k
&&\bigl(\because\ j < k\bigr)\\
&\leq j'
&&\bigl(\because\ k \leq j'\bigr)\\
&< j' + 1
&&\bigl(\because\ 1 > 0\bigr)\\
&= \delta^{m}_{k}(j')
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j' \geq k\bigr)
\end{aligned}`),
      paragraph([
        "となり仮定に反するので、この場合は起こらない。",
        math(String.raw`j' < k \leq j`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j')
&= j'
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j' < k\bigr)\\
&< k
&&\bigl(\because\ j' < k\bigr)\\
&\leq j
&&\bigl(\because\ k \leq j\bigr)\\
&< j + 1
&&\bigl(\because\ 1 > 0\bigr)\\
&= \delta^{m}_{k}(j)
&&\bigl(\because\ \blkref{def_index_skipping_map}\ \text{を右辺から左辺へ},\ j \geq k\bigr)
\end{aligned}`),
      paragraph([
        "となり仮定に反するので、この場合も起こらない。よって ",
        math(String.raw`j = j'`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを示す準備として、bijection_composed_with_index_skipping_map_is_bijective の単射性の段が使うので足した。Lean は Ising2D.skipIndex_injective（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimIndexSkippingMapProperties.lean）。数値検証: sagemath/check/index_skipping_map_is_injective/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_index_skipping_map_reaches_every_other_index",
    kind: "claim",
    title: { text: "一つの添字を飛ばす写像は飛ばした添字以外のすべてを値に取る" },
    labels: ["index_skipping_map_reaches_every_other_index"],
    lean: ["Ising2D.skipIndex_reaches_every_other_index"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。このとき、",
        math(String.raw`i \neq k`),
        " を満たすすべての ",
        math(String.raw`i \in \{1,\dots,m+1\}`),
        " について、",
        math(String.raw`\delta^{m}_{k}(j) = i`),
        " を満たす ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " がある。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m+1\}`),
        "、",
        math(String.raw`i \neq k`),
        " を取る。",
        math(String.raw`i < k`),
        " のとき、",
        math(String.raw`j := i`),
        " とおく。",
        math(String.raw`1 \leq i`),
        " であり、",
        math(String.raw`i < k \leq m+1`),
        " と ",
        math(String.raw`i \in \mathbb{Z}`),
        " から ",
        math(String.raw`i \leq m`),
        " なので ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j)
&= \delta^{m}_{k}(i)
&&\bigl(\because\ j\ \text{の置き方}\bigr)\\
&= i
&&\bigl(\because\ \blkref{def_index_skipping_map},\ i < k\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`i > k`),
        " のとき（",
        math(String.raw`i \neq k`),
        " なので ",
        math(String.raw`i < k`),
        " でなければこの場合である）、",
        math(String.raw`j := i - 1`),
        " とおく。",
        math(String.raw`i > k \geq 1`),
        " と ",
        math(String.raw`i \in \mathbb{Z}`),
        " から ",
        math(String.raw`i - 1 \geq 1`),
        "、",
        math(String.raw`i \leq m+1`),
        " から ",
        math(String.raw`i - 1 \leq m`),
        " なので ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " であり、",
        math(String.raw`i > k`),
        " と ",
        math(String.raw`i, k \in \mathbb{Z}`),
        " から ",
        math(String.raw`j = i - 1 \geq k`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta^{m}_{k}(j)
&= j + 1
&&\bigl(\because\ \blkref{def_index_skipping_map},\ j \geq k\bigr)\\
&= (i - 1) + 1
&&\bigl(\because\ j\ \text{の置き方}\bigr)\\
&= i
&&\bigl(\because\ -1 + 1 = 0\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを示す準備として、bijection_composed_with_index_skipping_map_is_bijective の全射性の段が使うので足した。Lean は Ising2D.skipIndex_reaches_every_other_index（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimIndexSkippingMapProperties.lean）。数値検証: sagemath/check/index_skipping_map_reaches_every_other_index/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_bijection_composed_with_index_skipping_map_stays_in_lower_indices",
    kind: "claim",
    title: { text: "最後の添字へ送られる添字を飛ばしてから全単射で送ると、最後の添字には届かない" },
    labels: ["bijection_composed_with_index_skipping_map_stays_in_lower_indices"],
    lean: ["Ising2D.bijection_comp_skipIndex_ne_last"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\pi : \{1,\dots,m+1\} \to \{1,\dots,m+1\}`),
        " を全単射、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " を ",
        math(String.raw`\pi(k) = m+1`),
        " を満たす添字とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。このとき、すべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`\pi(\delta^{m}_{k}(j)) \in \{1,\dots,m\}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j \in \{1,\dots,m\}`),
        " を取る。",
        math(String.raw`\pi(\delta^{m}_{k}(j)) = m+1`),
        " と仮定すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi(\delta^{m}_{k}(j))
&= m+1
&&\bigl(\because\ \text{仮定}\bigr)\\
&= \pi(k)
&&\bigl(\because\ \pi(k) = m+1\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\pi`),
        " は単射なので ",
        math(String.raw`\delta^{m}_{k}(j) = k`),
        " となって ",
        ref("index_skipping_map_never_takes_skipped_index"),
        " に反する。よって ",
        math(String.raw`\pi(\delta^{m}_{k}(j)) \neq m+1`),
        " である。",
        math(String.raw`\pi(\delta^{m}_{k}(j)) \in \{1,\dots,m+1\}`),
        " なので、",
        math(String.raw`\pi(\delta^{m}_{k}(j)) \in \{1,\dots,m\}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを m についての帰納法で示すとき、m → m+1 の段で残りの m 項の添字の付け替えを {1,…,m} の上の写像として定める def_bijection_composed_with_index_skipping_map が、値が {1,…,m} に入ることに使うので足した。Lean は Ising2D.bijection_comp_skipIndex_ne_last（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimBijectionComposedWithIndexSkippingMap.lean）。数値検証: sagemath/check/bijection_composed_with_index_skipping_map_stays_in_lower_indices/。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_bijection_composed_with_index_skipping_map",
    kind: "definition",
    title: { text: "最後の添字へ送られる添字を飛ばしてから全単射で送る写像" },
    labels: ["def_bijection_composed_with_index_skipping_map"],
    lean: ["Ising2D.bijectionCompSkipIndex", "Ising2D.bijectionCompSkipIndex_castSucc"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\pi : \{1,\dots,m+1\} \to \{1,\dots,m+1\}`),
        " を全単射、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " を ",
        math(String.raw`\pi(k) = m+1`),
        " を満たす添字とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        " による。写像 ",
        math(String.raw`\tau^{\pi}_{k} : \{1,\dots,m\} \to \{1,\dots,m\}`),
        " を",
      ]),
      displayMath(String.raw`\tau^{\pi}_{k}(j) := \pi(\delta^{m}_{k}(j))`),
      paragraph([
        "と定める。値が ",
        math(String.raw`\{1,\dots,m\}`),
        " に入ることは ",
        ref("bijection_composed_with_index_skipping_map_stays_in_lower_indices"),
        " による。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを m についての帰納法で示すとき、m → m+1 の段で、π(k) = m+1 の項を末尾へ移した残りの m 項の添字の付け替えとして帰納法の仮定に渡すので足した。Lean は Ising2D.bijectionCompSkipIndex（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimBijectionComposedWithIndexSkippingMap.lean）。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_bijection_composed_with_index_skipping_map_is_bijective",
    kind: "claim",
    title: { text: "最後の添字へ送られる添字を飛ばしてから全単射で送る写像は全単射である" },
    labels: ["bijection_composed_with_index_skipping_map_is_bijective"],
    lean: ["Ising2D.bijectionCompSkipIndex_bijective"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\pi : \{1,\dots,m+1\} \to \{1,\dots,m+1\}`),
        " を全単射、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " を ",
        math(String.raw`\pi(k) = m+1`),
        " を満たす添字とし、",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        "、",
        math(String.raw`\tau^{\pi}_{k}`),
        " は ",
        ref("def_bijection_composed_with_index_skipping_map"),
        " による。このとき ",
        math(String.raw`\tau^{\pi}_{k} : \{1,\dots,m\} \to \{1,\dots,m\}`),
        " は全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        "単射であることを示す。",
        math(String.raw`j, j' \in \{1,\dots,m\}`),
        " が ",
        math(String.raw`\tau^{\pi}_{k}(j) = \tau^{\pi}_{k}(j')`),
        " を満たすとすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi(\delta^{m}_{k}(j))
&= \tau^{\pi}_{k}(j)
&&\bigl(\because\ \blkref{def_bijection_composed_with_index_skipping_map}\ \text{を右辺から左辺へ}\bigr)\\
&= \tau^{\pi}_{k}(j')
&&\bigl(\because\ \text{仮定}\bigr)\\
&= \pi(\delta^{m}_{k}(j'))
&&\bigl(\because\ \blkref{def_bijection_composed_with_index_skipping_map}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\pi`),
        " は単射なので ",
        math(String.raw`\delta^{m}_{k}(j) = \delta^{m}_{k}(j')`),
        " であり、",
        ref("index_skipping_map_is_injective"),
        " より ",
        math(String.raw`j = j'`),
        " である。",
      ]),
      paragraph([
        "全射であることを示す。",
        math(String.raw`i \in \{1,\dots,m\}`),
        " を取る。",
        math(String.raw`\pi`),
        " は全射なので、",
        math(String.raw`\pi(p) = i`),
        " を満たす ",
        math(String.raw`p \in \{1,\dots,m+1\}`),
        " がある。",
        math(String.raw`p = k`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
i
&= \pi(p)
&&\bigl(\because\ \pi(p) = i\bigr)\\
&= \pi(k)
&&\bigl(\because\ p = k\bigr)\\
&= m+1
&&\bigl(\because\ \pi(k) = m+1\bigr)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`i \leq m`),
        " に反するので、",
        math(String.raw`p \neq k`),
        " である。",
        ref("index_skipping_map_reaches_every_other_index"),
        " より、",
        math(String.raw`\delta^{m}_{k}(j) = p`),
        " を満たす ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " があり",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau^{\pi}_{k}(j)
&= \pi(\delta^{m}_{k}(j))
&&\bigl(\because\ \blkref{def_bijection_composed_with_index_skipping_map}\bigr)\\
&= \pi(p)
&&\bigl(\because\ \delta^{m}_{k}(j) = p\bigr)\\
&= i
&&\bigl(\because\ \pi(p) = i\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。実数の有限和が添字の全単射による付け替えで変わらないことを m についての帰納法で示すとき、m → m+1 の段で帰納法の仮定を τ^π_k に当てるので足した。Lean は Ising2D.bijectionCompSkipIndex_bijective（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimBijectionComposedWithIndexSkippingMap.lean）。数値検証: sagemath/check/bijection_composed_with_index_skipping_map_is_bijective/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing",
    kind: "claim",
    title: { text: "実数の有限和は添字の全単射による付け替えで変わらない" },
    labels: ["finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing"],
    lean: ["Ising2D.finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_m \in \mathbb{R}`),
        "、",
        math(String.raw`\pi : \{1,\dots,m\} \to \{1,\dots,m\}`),
        " を全単射とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} a_{\pi(j)} = \sum_{j=1}^{m} a_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す（各 ",
        math(String.raw`m`),
        " で、すべての ",
        math(String.raw`a_1,\dots,a_m \in \mathbb{R}`),
        " と全単射 ",
        math(String.raw`\pi : \{1,\dots,m\} \to \{1,\dots,m\}`),
        " についての主張を示す）。",
        math(String.raw`m = 1`),
        " のとき、",
        math(String.raw`\pi(1) \in \{1\}`),
        " なので ",
        math(String.raw`\pi(1) = 1`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} a_{\pi(j)}
&= a_{\pi(1)}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= a_1
&&\bigl(\because\ \pi(1) = 1\bigr)\\
&= \sum_{j=1}^{1} a_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1} \in \mathbb{R}`),
        " と全単射 ",
        math(String.raw`\pi : \{1,\dots,m+1\} \to \{1,\dots,m+1\}`),
        " を取る。",
        math(String.raw`\pi`),
        " は全射なので、",
        math(String.raw`\pi(k) = m+1`),
        " を満たす ",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " がある。",
        math(String.raw`\delta^{m}_{k}`),
        " は ",
        ref("def_index_skipping_map"),
        "、",
        math(String.raw`\tau^{\pi}_{k} : \{1,\dots,m\} \to \{1,\dots,m\}`),
        " は ",
        ref("def_bijection_composed_with_index_skipping_map"),
        " による。",
        math(String.raw`j \in \{1,\dots,m+1\}`),
        " について ",
        math(String.raw`b_j := a_{\pi(j)}`),
        " とおく（",
        math(String.raw`b_j \in \mathbb{R}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_{\pi(j)}
&= \sum_{j=1}^{m+1} b_j
&&\bigl(\because\ b_j\ \text{の置き方}\bigr)\\
&= \Bigl(\sum_{j=1}^{m} b_{\delta^{m}_{k}(j)}\Bigr) + b_k
&&\bigl(\because\ \blkref{finite_sum_of_real_numbers_moves_one_term_to_end}\bigr)\\
&= \Bigl(\sum_{j=1}^{m} a_{\pi(\delta^{m}_{k}(j))}\Bigr) + a_{\pi(k)}
&&\bigl(\because\ b_j\ \text{の置き方}\bigr)\\
&= \Bigl(\sum_{j=1}^{m} a_{\tau^{\pi}_{k}(j)}\Bigr) + a_{\pi(k)}
&&\bigl(\because\ \blkref{def_bijection_composed_with_index_skipping_map}\ \text{を右辺から左辺へ各項へ}\bigr)\\
&= \Bigl(\sum_{j=1}^{m} a_{\tau^{\pi}_{k}(j)}\Bigr) + a_{m+1}
&&\bigl(\because\ \pi(k) = m+1\bigr)\\
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \text{帰納法の仮定（}a_1,\dots,a_m\ \text{と、}\blkref{bijection_composed_with_index_skipping_map_is_bijective}\ \text{により全単射である}\ \tau^{\pi}_{k}\ \text{について）}\bigr)\\
&= \sum_{j=1}^{m+1} a_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 を ε_ℝ で書き直すときに ‖ε_ℝu‖ = ‖u‖ を示すのに、二乗の和の添字を π(k) := ord(-ord^{-1}(k)) で付け替えるので足した。Lean は Ising2D.finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumOfRealNumbersReindexedByBijection.lean）、必要十分版は Ising2D.NecSuf.finite_sum_reindex_bijective'（NecSuf/FiniteSumReindexedByBijection.lean）。数値検証: sagemath/check/finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing/。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_real_absolute_value",
    kind: "definition",
    title: { text: "実数の絶対値" },
    labels: ["def_real_absolute_value"],
    statement: [
      paragraph([
        math(String.raw`q \in \mathbb{R}`),
        " について、実数の絶対値 ",
        math(String.raw`|q| \in \mathbb{R}`),
        " を",
      ]),
      displayMath(String.raw`|q| :=
\begin{cases}
q & (q \geq 0),\\
-q & (q < 0)
\end{cases}`),
      paragraph([
        "と定める（",
        math(String.raw`-q`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の符号反転）。",
        math(String.raw`q \geq 0`),
        " なら ",
        math(String.raw`|q| = q \geq 0`),
        "、",
        math(String.raw`q < 0`),
        " なら ",
        math(String.raw`|q| = -q > 0`),
        " なので、",
        math(String.raw`|q| \in \mathbb{R}_{\geq 0}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。本文の各所が「実数の絶対値の定め方」を名前だけで使っていたが、引ける定義のブロックが無かった。def_rayleigh_sup の上に有界であることの鎖を引ける形にするために足した主張（real_number_is_at_most_its_absolute_value ほか）が引けるよう、先に置いた。既存の名前だけの箇所は、それぞれのブロックを扱うときに参照へ替える。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_number_is_at_most_its_absolute_value",
    kind: "claim",
    title: { text: "実数は絶対値以下" },
    labels: ["real_number_is_at_most_its_absolute_value"],
    lean: ["Ising2D.real_number_is_at_most_its_absolute_value"],
    statement: [
      paragraph([
        math(String.raw`q \in \mathbb{R}`),
        " とする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。このとき",
      ]),
      displayMath(String.raw`q \leq |q|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`q \geq 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
q
&= |q|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \geq 0)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`q < 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
q
&< 0
&&\bigl(\because\ q < 0\bigr)\\
&< -q
&&\bigl(\because\ q < 0\ \text{の両辺の符号を反転する}\bigr)\\
&= |q|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q < 0)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の上に有界であることの鎖が、𝓡 の元 x^⊤Wx をその絶対値で上から抑える段を書いていなかったので、その段と real_abs_triangle_inequality の証明から引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_negative_absolute_value_is_at_most_real_number",
    kind: "claim",
    title: { text: "絶対値の符号反転は実数以下" },
    labels: ["negative_absolute_value_is_at_most_real_number"],
    lean: ["Ising2D.negative_absolute_value_is_at_most_real_number"],
    statement: [
      paragraph([
        math(String.raw`q \in \mathbb{R}`),
        " とする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。このとき",
      ]),
      displayMath(String.raw`-|q| \leq q`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`q \geq 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
-|q|
&= -q
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \geq 0)\bigr)\\
&\leq 0
&&\bigl(\because\ q \geq 0\ \text{の両辺の符号を反転する}\bigr)\\
&\leq q
&&\bigl(\because\ q \geq 0\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`q < 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
-|q|
&= -(-q)
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q < 0)\bigr)\\
&= q
&&\bigl(\because\ \mathbb{R}\ \text{で}\ -(-q) = q\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。real_abs_triangle_inequality の証明（a + b < 0 の場合）から引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_absolute_value_of_nonpositive",
    kind: "claim",
    title: { text: "0 以下の実数の絶対値は符号反転" },
    labels: ["real_absolute_value_of_nonpositive"],
    lean: ["Ising2D.real_absolute_value_of_nonpositive"],
    statement: [
      paragraph([
        math(String.raw`q \in \mathbb{R}`),
        " が ",
        math(String.raw`q \leq 0`),
        " を満たすとする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。このとき",
      ]),
      displayMath(String.raw`|q| = -q`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`q < 0`),
        " のときは ",
        ref("def_real_absolute_value"),
        "（",
        math(String.raw`q < 0`),
        "）そのものである。",
        math(String.raw`q = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
|q|
&= q
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \geq 0)\bigr)\\
&= 0
&&\bigl(\because\ q = 0\bigr)\\
&= -0
&&\bigl(\because\ \blkref{real_negation_of_zero_is_zero}\ \text{を右辺から左辺へ}\bigr)\\
&= -q
&&\bigl(\because\ q = 0\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。real_abs_of_product の証明で ab ≤ 0 の場合の絶対値を出す段から引けるよう足した。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: q = 0 の鎖の 3 行目の名前だけの根拠「ℝ で −0 = 0」を real_negation_of_zero_is_zero を右辺から左辺へ当てる参照に替えた。式は不変。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_abs_triangle_inequality",
    kind: "claim",
    title: { text: "実数の絶対値の三角不等式" },
    labels: ["real_abs_triangle_inequality"],
    lean: ["Ising2D.real_abs_triangle_inequality"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " とする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。このとき",
      ]),
      displayMath(String.raw`|a + b| \leq |a| + |b|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("real_number_is_at_most_its_absolute_value"),
        "（",
        math(String.raw`q \to a`),
        "、",
        math(String.raw`q \to b`),
        "）より ",
        math(String.raw`a \leq |a|`),
        "、",
        math(String.raw`b \leq |b|`),
        " である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
-a
&\leq -(-|a|)
&&\bigl(\because\ \blkref{negative_absolute_value_is_at_most_real_number}\ (q \to a)\ \text{の}\ -|a| \leq a\ \text{の両辺の符号を反転する}\bigr)\\
&= |a|
&&\bigl(\because\ \mathbb{R}\ \text{で}\ -(-|a|) = |a|\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-b
&\leq -(-|b|)
&&\bigl(\because\ \blkref{negative_absolute_value_is_at_most_real_number}\ (q \to b)\ \text{の}\ -|b| \leq b\ \text{の両辺の符号を反転する}\bigr)\\
&= |b|
&&\bigl(\because\ \mathbb{R}\ \text{で}\ -(-|b|) = |b|\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`a + b \geq 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
|a + b|
&= a + b
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a + b \geq 0)\bigr)\\
&\leq |a| + b
&&\bigl(\because\ a \leq |a|\ \text{の両辺に}\ b\ \text{を足す}\bigr)\\
&\leq |a| + |b|
&&\bigl(\because\ b \leq |b|\ \text{の両辺に}\ |a|\ \text{を足す}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`a + b < 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
|a + b|
&= -(a + b)
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a + b < 0)\bigr)\\
&= (-a) + (-b)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ (x \to a,\ y \to b)\bigr)\\
&\leq |a| + (-b)
&&\bigl(\because\ -a \leq |a|\ \text{の両辺に}\ -b\ \text{を足す}\bigr)\\
&\leq |a| + |b|
&&\bigl(\because\ -b \leq |b|\ \text{の両辺に}\ |a|\ \text{を足す}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。finite_sum_of_real_numbers_triangle_inequality の帰納法の段から引けるよう足した（def_rayleigh_sup の上に有界であることの鎖が「有限和の三角不等式」を名前だけで使っていた）。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: a + b < 0 の場合の根拠「ℝ で −(a+b) = (−a)+(−b)」を、この回に足した主張 real_negation_of_sum_is_sum_of_negations（x → a, y → b）の参照にした（文書の並びでは後ろのファイルのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_abs_of_product",
    kind: "claim",
    title: { text: "実数の積の絶対値は絶対値の積" },
    labels: ["real_abs_of_product"],
    lean: ["Ising2D.real_abs_of_product"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " とする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。このとき",
      ]),
      displayMath(String.raw`|ab| = |a|\,|b|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " の符号で 4 つに場合を分ける。",
        math(String.raw`a \geq 0`),
        " かつ ",
        math(String.raw`b \geq 0`),
        " のとき。非負の実数の積は非負なので ",
        math(String.raw`ab \geq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
|ab|
&= ab
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (ab \geq 0)\bigr)\\
&= |a|\,b
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a \geq 0)\bigr)\\
&= |a|\,|b|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (b \geq 0)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`a \geq 0`),
        " かつ ",
        math(String.raw`b < 0`),
        " のとき。",
        math(String.raw`-b > 0`),
        " なので非負の実数の積として ",
        math(String.raw`a(-b) \geq 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
ab
&= -(-(ab))
&&\bigl(\because\ \blkref{real_double_negation}\ \text{の}\ -(-a) = a\ \text{の文字を}\ p\ \text{に替えた}\ -(-p) = p\ (p \to ab)\ \text{を右辺から左辺へ}\bigr)\\
&= -(a(-b))
&&\bigl(\because\ \blkref{real_times_negation_is_negation_of_product}\ (x \to a,\ t \to b)\ \text{を右辺から左辺へ}\bigr)\\
&\leq 0
&&\bigl(\because\ a(-b) \geq 0\ \text{の両辺の符号を反転}\bigr)
\end{aligned}`),
      paragraph([
        "である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
|ab|
&= -(ab)
&&\bigl(\because\ \blkref{real_absolute_value_of_nonpositive}\ (q \to ab)\bigr)\\
&= a(-b)
&&\bigl(\because\ \blkref{real_times_negation_is_negation_of_product}\ (x \to a,\ t \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= |a|\,(-b)
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a \geq 0)\bigr)\\
&= |a|\,|b|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (b < 0)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`a < 0`),
        " かつ ",
        math(String.raw`b \geq 0`),
        " のとき。",
        math(String.raw`-a > 0`),
        " なので非負の実数の積として ",
        math(String.raw`(-a)b \geq 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
ab
&= -(-(ab))
&&\bigl(\because\ \blkref{real_double_negation}\ \text{の}\ -(-a) = a\ \text{の文字を}\ p\ \text{に替えた}\ -(-p) = p\ (p \to ab)\ \text{を右辺から左辺へ}\bigr)\\
&= -((-a)b)
&&\bigl(\because\ \blkref{real_negation_times_is_negation_of_product}\ (x \to a,\ t \to b)\ \text{を右辺から左辺へ}\bigr)\\
&\leq 0
&&\bigl(\because\ (-a)b \geq 0\ \text{の両辺の符号を反転}\bigr)
\end{aligned}`),
      paragraph([
        "である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
|ab|
&= -(ab)
&&\bigl(\because\ \blkref{real_absolute_value_of_nonpositive}\ (q \to ab)\bigr)\\
&= (-a)\,b
&&\bigl(\because\ \blkref{real_negation_times_is_negation_of_product}\ (x \to a,\ t \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= |a|\,b
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a < 0)\bigr)\\
&= |a|\,|b|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (b \geq 0)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`a < 0`),
        " かつ ",
        math(String.raw`b < 0`),
        " のとき。",
        math(String.raw`-a > 0`),
        "、",
        math(String.raw`-b > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
ab
&= (-a)(-b)
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ (a \to a,\ b \to b)\ \text{を右辺から左辺へ}\bigr)\\
&\geq 0
&&\bigl(\because\ -a > 0,\ -b > 0\ \text{なので非負の実数の積}\bigr)
\end{aligned}`),
      paragraph([
        "である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
|ab|
&= ab
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (ab \geq 0)\bigr)\\
&= (-a)(-b)
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ (a \to a,\ b \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= |a|\,(-b)
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (a < 0)\bigr)\\
&= |a|\,|b|
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (b < 0)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の上に有界であることの鎖が「積の絶対値」を名前だけで使っていたので、引けるよう足した。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: −(ab) = (−a)b の行の根拠「ℝ で −(ab) = (−a)b」を、主張 real_negation_times_is_negation_of_product（x → a, t → b を右辺から左辺へ。文書の並びでは後ろのブロック。依存先にこの主張は無く循環しない）の参照にした。式・鎖の両端・段数は不変。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: a ≥ 0 かつ b < 0 の鎖の −(ab) = a(−b) の行の根拠「ℝ で −(ab) = a(−b)」を、主張 real_times_negation_is_negation_of_product（x → a, t → b を右辺から左辺へ）の参照にした（文書の並びでは後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: a ≥ 0 かつ b < 0、a < 0 かつ b ≥ 0 の前置きが ab = −(a(−b))・ab = −((−a)b) を根拠なしに書いていた（(−x)t = −(xt) または x(−t) = −(xt) と −(−y) = y を一度に使う）ので、それぞれ ab から始めて ≤ 0 に着く 3 行の鎖（real_double_negation の文字を p に替えた −(−p) = p を右辺から左辺へ、real_times_negation_is_negation_of_product または real_negation_times_is_negation_of_product を右辺から左辺へ、両辺の符号の反転）に割った。a < 0 かつ b < 0 の前置きを ab = (−a)(−b) ≥ 0 の 2 行の鎖にし、その 1 行目と |ab| の鎖の 2 行目の「ℝ で ab = (−a)(−b)」を real_negation_times_negation_is_product（右辺から左辺へ）の参照にした。いずれも文書の並びでは後ろのブロックで、依存先にこの主張は無く循環しない。主張・各場合の |ab| の鎖は不変。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_square_of_real_number_is_product",
    kind: "claim",
    title: { text: "実数の二乗は、その実数を二つ掛けた積に等しい" },
    labels: ["square_of_real_number_is_product"],
    lean: ["Ising2D.square_of_real_number_is_product"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{R}`),
        " とする。二乗 ",
        math(String.raw`r^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）、積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。このとき",
      ]),
      displayMath(String.raw`r^2 = r\,r`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
r^2
&= r^1\,r
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to r,\ m \to 1)\bigr)\\
&= (r^0\,r)\,r
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to r,\ m \to 0)\bigr)\\
&= (1\,r)\,r
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to r)\bigr)\\
&= r\,r
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。本文の実数の二乗が、ブロックごとにその場で置く r^2 := rr と def_power_of_real_number の冪の 2 つの意味で同じ記号を使っていた（記号の濫用）ので、二乗を def_power_of_real_number の冪に一本化し、積の形はこの主張から引くようにした。Lean は Ising2D.square_of_real_number_is_product（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealNumberIsProduct.lean）。数値検証: sagemath/check/square_of_real_number_is_product/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（power_of_real_one_is_one と同じ扱い）。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_square_is_nonnegative",
    kind: "claim",
    title: { text: "実数の二乗は 0 以上" },
    labels: ["real_square_is_nonnegative"],
    lean: ["Ising2D.real_square_is_nonnegative"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{R}`),
        " とする。二乗 ",
        math(String.raw`r^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）、",
        math(String.raw`0`),
        "・",
        math(String.raw`\le`),
        " は ",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`\mathbb{R}`),
        " の零元・順序である。このとき",
      ]),
      displayMath(String.raw`0 \le r^2`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`0 \le r`),
        " の場合と、そうでない場合に分ける。",
        math(String.raw`0 \le r`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\le r\,r
&&\bigl(\because\ \text{場合の仮定}\ 0 \le r\ \text{に}\ \mathbb{R}\ \text{の順序と乗法の両立}\ (0 \le x\ \wedge\ 0 \le y) \Rightarrow 0 \le x\cdot y\ (x \to r,\ y \to r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= r^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to r)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\neg\,(0 \le r)`),
        " のとき、",
        math(String.raw`\mathbb{R}`),
        " の全順序 ",
        math(String.raw`0 \le r \vee r \le 0`),
        "（",
        ref("set_and_algebra_notation"),
        " の ",
        math(String.raw`x \to 0,\ y \to r`),
        "）の左が成り立たないので ",
        math(String.raw`r \le 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&= r + (-r)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to r)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\le 0 + (-r)
&&\bigl(\because\ r \le 0\ \text{に}\ \mathbb{R}\ \text{の順序と加法の両立}\ x \le y \Rightarrow x + t \le y + t\ (x \to r,\ y \to 0,\ t \to -r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -r
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。この ",
        math(String.raw`0 \le -r`),
        " から",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\le (-r)\cdot(-r)
&&\bigl(\because\ 0 \le -r\ \text{に}\ \mathbb{R}\ \text{の順序と乗法の両立}\ (x \to -r,\ y \to -r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= r\,r
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ (a \to r,\ b \to r)\bigr)\\
&= r^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to r)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。どちらの場合も ", math(String.raw`0 \le r^2`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-28（Lean の点検の直し、未定義の記号の行「ℝ の数・順序・差・商」の順序の (a) の残り）: 原文（Typst）に対応ブロックは無い。closed_form_log_integral の準備が「上の 0 < δ² から δ²+θ²/4 ≥ δ² > 0」と根拠を書かずに述べており、Lean の具体版は θ²/4 ≥ 0 を mathlib の sq_nonneg で閉じていた。その部品として、set_and_algebra_notation の ℝ の行（全順序・加法の逆元・順序と加法の両立・加法の単位元・順序と乗法の両立）と square_of_real_number_is_product・real_negation_times_negation_is_product から示す主張を足した（int_absolute_value_is_nonnegative と同じ場合分け）。Lean の具体版は Ising2D.real_square_is_nonnegative（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealSquareIsNonnegative.lean）、必要十分版は Ising2D.NecSuf.sq_nonneg_of_cases（NecSuf/SqNonnegOfCases.lean）。数値検証: sagemath/check/real_square_is_nonnegative/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_square_of_real_absolute_value",
    kind: "claim",
    title: { text: "実数の絶対値の二乗は、もとの実数の二乗に等しい" },
    labels: ["square_of_real_absolute_value"],
    lean: ["Ising2D.square_of_real_absolute_value"],
    statement: [
      paragraph([
        math(String.raw`q \in \mathbb{R}`),
        " とする。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値、二乗は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。このとき",
      ]),
      displayMath(String.raw`|q|^2 = q^2`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`q \geq 0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
|q|^2
&= q^2
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \geq 0)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`q < 0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
|q|^2
&= (-q)^2
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q < 0)\bigr)\\
&= (-q)(-q)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to -q)\bigr)\\
&= q\,q
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-a)(-b) = ab\ (a, b \to q)\bigr)\\
&= q^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to q)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_matrix_norm（K = ℝ）のノルムの二乗は成分の絶対値の二乗の和なので、成分の二乗の評価（square_of_real_sum_is_at_most_twice_sum_of_squares）へ渡すために足した。norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four が引く。数値検証: sagemath/check/square_of_real_absolute_value/。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 二乗をその場の r^2 := rr から def_power_of_real_number の冪に替え、積の形へ開く行を square_of_real_number_is_product で引く行として足した（記号の濫用の解消）。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_square_of_real_sum_is_at_most_twice_sum_of_squares",
    kind: "claim",
    title: { text: "二つの実数の和の二乗は、二乗の和の 2 倍以下" },
    labels: ["square_of_real_sum_is_at_most_twice_sum_of_squares"],
    lean: ["Ising2D.square_of_real_sum_is_at_most_twice_sum_of_squares"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " とする。二乗は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。このとき",
      ]),
      displayMath(String.raw`(a + b)^2 \leq 2a^2 + 2b^2`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("real_square_is_nonnegative"),
        "（",
        math(String.raw`r \to a - b`),
        "）から ",
        math(String.raw`0 \leq (a - b)^2`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a + b)^2
&= (a + b)^2 + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\bigr)\\
&\leq (a + b)^2 + (a - b)^2
&&\bigl(\because\ \text{上の}\ 0 \leq (a - b)^2\ \text{と}\ \mathbb{R}\ \text{の順序と加法の両立}\ (x \leq y \Rightarrow c + x \leq c + y)\ (c \to (a + b)^2)\bigr)\\
&= (a + b)(a + b) + (a - b)(a - b)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to a + b,\ r \to a - b)\ \text{を 2 か所へ同時適用}\bigr)\\
&= \bigl(aa + ab + ba + bb\bigr) + \bigl(aa - ab - ba + bb\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律による展開を 2 か所へ同時適用}\bigr)\\
&= \bigl(a^2 + ab + ba + b^2\bigr) + \bigl(a^2 - ab - ba + b^2\bigr)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to a,\ r \to b)\ \text{を右辺から左辺へ 4 か所同時適用}\bigr)\\
&= 2a^2 + 2b^2
&&\bigl(\because\ \mathbb{R}\ \text{の加法と減法の計算}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-28（Lean の点検の直し、行「ℝ の数・順序・差・商」の順序の (a)）: 名前だけで引いていた「実数の平方は非負」を、新しく足した主張 real_square_is_nonnegative の参照にした。Lean の具体版の sq_nonneg も同じ主張にした。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 の ‖v‖^2 ≤ 4 を、成分ごとの評価 |v_k|^2 ≤ 2|u_k|^2 + 2|(ε_ℝu)_k|^2 から示すために足した。norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four が引く。数値検証: sagemath/check/square_of_real_sum_is_at_most_twice_sum_of_squares/。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 二乗をその場の r^2 := rr から def_power_of_real_number の冪に替え、積の形へ開く行を square_of_real_number_is_product で引く行として足した（記号の濫用の解消）。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_numbers_triangle_inequality",
    kind: "claim",
    title: { text: "実数の有限和の三角不等式" },
    labels: ["finite_sum_of_real_numbers_triangle_inequality"],
    lean: ["Ising2D.finite_sum_of_real_numbers_triangle_inequality", "Ising2D.finite_sum_of_real_numbers_triangle_inequality_succ", "Ising2D.finite_sum_of_real_numbers_triangle_inequality_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`a_1,\dots,a_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        "、",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値による。このとき",
      ]),
      displayMath(String.raw`\left|\sum_{j=1}^{m} a_j\right| \leq \sum_{j=1}^{m} |a_j|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\sum_{j=1}^{0} a_j\right|
&= |0|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \to 0)\ \text{の}\ q \geq 0\ \text{の場合}\bigr)\\
&= \sum_{j=1}^{0} |a_j|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to |a_j|)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "だから成り立つ。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\sum_{j=1}^{1} a_j\right|
&= |a_1|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= \sum_{j=1}^{1} |a_j|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to |a_j|)\bigr)
\end{aligned}`),
      paragraph([
        "だから成り立つ。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\sum_{j=1}^{m+1} a_j\right|
&= \left|\Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}\right|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\leq \left|\sum_{j=1}^{m} a_j\right| + |a_{m+1}|
&&\bigl(\because\ \blkref{real_abs_triangle_inequality}\ (a \to \textstyle\sum_{j=1}^{m} a_j,\ b \to a_{m+1})\bigr)\\
&\leq \Bigl(\sum_{j=1}^{m} |a_j|\Bigr) + |a_{m+1}|
&&\bigl(\because\ \text{帰納法の仮定の両辺に}\ |a_{m+1}|\ \text{を足す}\bigr)\\
&= \sum_{j=1}^{m+1} |a_j|
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to |a_j|)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の上に有界であることの鎖が「有限和の三角不等式」を名前だけで使っていたので、引けるよう足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_numbers_is_monotone",
    kind: "claim",
    title: { text: "項ごとの大小は実数の有限和の大小に移る" },
    labels: ["finite_sum_of_real_numbers_is_monotone"],
    lean: ["Ising2D.finite_sum_of_real_numbers_is_monotone", "Ising2D.finite_sum_of_real_numbers_is_monotone_succ", "Ising2D.finite_sum_of_real_numbers_is_monotone_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`a_1,\dots,a_m, b_1,\dots,b_m \in \mathbb{R}`),
        " がすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`a_j \leq b_j`),
        " を満たすとする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} a_j \leq \sum_{j=1}^{m} b_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{0} a_j
&= 0
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to a_j)\bigr)\\
&= \sum_{j=1}^{0} b_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の}\ \textstyle\sum_{j=1}^{0} r_j := 0\ (r_j \to b_j)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "だから成り立つ。",
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " は ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} a_j
&= a_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\leq b_1
&&\bigl(\because\ \text{仮定}\ a_1 \leq b_1\bigr)\\
&= \sum_{j=1}^{1} b_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1}, b_1,\dots,b_{m+1} \in \mathbb{R}`),
        " がすべての ",
        math(String.raw`j \in \{1,\dots,m+1\}`),
        " で ",
        math(String.raw`a_j \leq b_j`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_j
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\leq \Bigl(\sum_{j=1}^{m} b_j\Bigr) + a_{m+1}
&&\bigl(\because\ \text{帰納法の仮定（}a_1,\dots,a_m\ \text{と}\ b_1,\dots,b_m\text{）の両辺に}\ a_{m+1}\ \text{を足す}\bigr)\\
&\leq \Bigl(\sum_{j=1}^{m} b_j\Bigr) + b_{m+1}
&&\bigl(\because\ a_{m+1} \leq b_{m+1}\ \text{の両辺に}\ \textstyle\sum_{j=1}^{m} b_j\ \text{を足す}\bigr)\\
&= \sum_{j=1}^{m+1} b_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の上に有界であることの鎖が「|x_i| ≤ 1, |x_j| ≤ 1」の名前だけで項ごとの評価を有限和へ移していたので、引けるよう足した。",
        "2026-11-25（Lean の点検の直し、状態台帳の行「有限和と有限集合の記号」の三単位目）: def_finite_sum_of_real_numbers が項の無い族の和 Σ_{j=1}^{0} r_j := 0 を定めたので、主張の m の範囲を ℤ_{≥1} から ℤ_{≥0} へ広げ、証明の冒頭に m = 0 の鎖（空の和の式から引く）を足した。m ≥ 1 の帰納法の鎖は変えていない。Lean の m = 0 の段は Fin.sum_univ_zero から finset_sum_fin_real_eq_finite_sum_of_real_numbers の空の和の式へ替えた。数値検証に m = 0 を足した。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_maximum_value_of_real_family",
    kind: "definition",
    title: { text: "実数の族の最大値" },
    labels: ["def_maximum_value_of_real_family"],
    lean: ["Ising2D.IsMaxValueOfRealFamily"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`S`),
        " と、",
        math(String.raw`S`),
        " の元 ",
        math(String.raw`i`),
        " ごとに一つの実数 ",
        math(String.raw`x_i \in \mathbb{R}`),
        " を与える族 ",
        math(String.raw`(x_i)_{i \in S}`),
        " について、実数 ",
        math(String.raw`m \in \mathbb{R}`),
        " が族 ",
        math(String.raw`(x_i)_{i \in S}`),
        " の最大値であるとは、次の二つが成り立つことをいう。",
      ]),
      displayMath(String.raw`\text{(1)}\quad \text{ある}\ i_0 \in S\ \text{について}\ x_{i_0} = m,
\qquad
\text{(2)}\quad \text{すべての}\ i \in S\ \text{について}\ x_i \leq m`),
      paragraph([
        "順序 ",
        math(String.raw`\leq`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の順序である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。V_plus_eigenvalues_with_c_value_and_strict_maximum (4) の「集合 {Λ̌_ε} は有限集合で Λ̌_{(1,…,1)} を含み、他の元は小さいので最大元が存在して max = Λ̌_{(1,…,1)}」が最大値と max を定義せずに使っていたので、引けるよう足した。S の有限性と空でないことは、最大値の存在を言うためには要らない（最大値になる元を直接示す）ので仮定しない。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_maximum_value_of_real_family_is_unique",
    kind: "claim",
    title: { text: "実数の族の最大値は一つしかない" },
    labels: ["maximum_value_of_real_family_is_unique"],
    lean: ["Ising2D.maximum_value_of_real_family_is_unique"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`S`),
        " 上の実数の族 ",
        math(String.raw`(x_i)_{i \in S}`),
        " について、",
        math(String.raw`m, m' \in \mathbb{R}`),
        " がどちらも ",
        ref("def_maximum_value_of_real_family"),
        " の意味で族 ",
        math(String.raw`(x_i)_{i \in S}`),
        " の最大値ならば、",
        math(String.raw`m = m'`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x_{i_0} = m`),
        " となる ",
        math(String.raw`i_0 \in S`),
        " と、",
        math(String.raw`x_{i_0'} = m'`),
        " となる ",
        math(String.raw`i_0' \in S`),
        " を取る。",
      ]),
      displayMath(String.raw`i_0,\ i_0' \in S\ \text{が取れる}
\qquad \bigl(\because\ m, m'\ \text{それぞれについて}\ \blkref{def_maximum_value_of_real_family}\ \text{の (1)}\bigr)`),
      displayMath(String.raw`\begin{aligned}
m
&= x_{i_0}
&&\bigl(\because\ i_0\ \text{の取り方}\bigr)\\
&\leq m'
&&\bigl(\because\ m'\ \text{について}\ \blkref{def_maximum_value_of_real_family}\ \text{(2) を}\ i = i_0\ \text{で使う}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
m'
&= x_{i_0'}
&&\bigl(\because\ i_0'\ \text{の取り方}\bigr)\\
&\leq m
&&\bigl(\because\ m\ \text{について}\ \blkref{def_maximum_value_of_real_family}\ \text{(2) を}\ i = i_0'\ \text{で使う}\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`m = m'
\qquad \bigl(\because\ \text{上の二本の鎖の}\ m \leq m'\ \text{と}\ m' \leq m\ \text{に}\ \mathbb{R}\ \text{の順序の反対称律を使う}\bigr)`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。記号 max（def_max_of_real_family）が一つの実数を指すために要るので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_max_of_real_family",
    kind: "definition",
    title: { text: "実数の族の最大値の記号 max" },
    labels: ["def_max_of_real_family"],
    lean: ["Ising2D.maxOfRealFamily", "Ising2D.maxOfRealFamily_eq"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`S`),
        " 上の実数の族 ",
        math(String.raw`(x_i)_{i \in S}`),
        " が ",
        ref("def_maximum_value_of_real_family"),
        " の意味の最大値をもつとき、その最大値を",
      ]),
      displayMath(String.raw`\max_{i \in S} x_i \in \mathbb{R}`),
      paragraph([
        "と書く。最大値は ",
        ref("maximum_value_of_real_family_is_unique"),
        " により一つしかないので、この記号は一つの実数を指す。",
        math(String.raw`S`),
        " が文脈から分かるときは ",
        math(String.raw`\max_{i} x_i`),
        " とも書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。V_plus_eigenvalues_with_c_value_and_strict_maximum (4) と章のゴール（chapter_organization_goal_eigenvalues_of_V_plus）の max_ε Λ̌_ε を定義するために足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_product",
    kind: "claim",
    title: { text: "実数の積の包含は包含の積に等しい" },
    labels: ["real_inclusion_preserves_product"],
    lean: ["Ising2D.real_inclusion_mul"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`a_{\mathbb{C}}\, b_{\mathbb{C}} = (ab)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a_{\mathbb{C}}\, b_{\mathbb{C}}
&= (a, 0)\,(b, 0)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (a b - 0\cdot 0,\ a\cdot 0 + 0\cdot b)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (a b - 0\cdot 0,\ 0 + 0\cdot b)
&&(\because\ \blkref{real_times_zero_is_zero}\ (x \to a))\\
&= (a b - 0,\ 0 + 0)
&&(\because\ \blkref{real_zero_times_is_zero}\ \text{を 2 箇所へ}\ (x \to 0,\ x \to b))\\
&= (a b,\ 0 + 0)
&&(\because\ \blkref{real_minus_zero_is_self}\ (a \to a b))\\
&= (a b,\ 0)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= (ab)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。first_transfer_matrix_pauli_form の証明の D の対角成分と成分の一致の鎖が、包含と ℂ の積の定義を開いて計算する段を一行で使っていたので、主張にして引けるようにした。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 3 行目の名前だけの根拠「ℝ で x·0 = 0 と 0·x = 0（ℝ は体）を 3 箇所へ適用」（2 つの事実を 1 行で使っていた）を、real_times_zero_is_zero（x → a）の行と real_zero_times_is_zero を 2 箇所へ（x → 0, x → b）の行に割った（鎖の両端は不変）。2 つの主張は後ろのファイル 000_calculation_formulae_20_29.ts にあり、ここからは前方参照になる（検査は落とさない。置き場は状態台帳の定義より前の参照の件で扱う）。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 5 行目の名前だけの根拠「ℝ で x − 0 = x と 0 + 0 = 0」（2 つの事実を 1 行で使っていた）を、real_minus_zero_is_self（a → ab）の行と「ℝ で 0 + 0 = 0」の行に割った（鎖の両端は不変）。real_minus_zero_is_self も後ろのファイル 000_calculation_formulae_20_29.ts にあり、前方参照になる。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_real_inclusion_preserves_difference",
    kind: "claim",
    title: { text: "実数の差の包含は包含の差に等しい" },
    labels: ["real_inclusion_preserves_difference"],
    lean: ["Ising2D.real_inclusion_sub"],
    statement: [
      paragraph([
        math(String.raw`y, z \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`y_{\mathbb{C}} - z_{\mathbb{C}} = (y - z)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の差は ",
        ref("def_complex_difference"),
        " の差、右辺の差は ",
        ref("def_real_difference"),
        " の差である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
y_{\mathbb{C}} - z_{\mathbb{C}}
&= y_{\mathbb{C}} + \bigl(-z_{\mathbb{C}}\bigr)
&&(\because\ \blkref{def_complex_difference})\\
&= y_{\mathbb{C}} + (-1_{\mathbb{C}})\,z_{\mathbb{C}}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= y_{\mathbb{C}} + (-1)_{\mathbb{C}}\,z_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1) = (-1)_{\mathbb{C}})\\
&= y_{\mathbb{C}} + \bigl((-1)\,z\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(y + (-1)\,z\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_sum})\\
&= \bigl(y + (-z)\bigr)_{\mathbb{C}}
&&(\because\ \text{実数の四則（順序体}\ \mathbb{R}\ \text{で}\ (-1)\,z\ \text{は}\ z\ \text{の加法の逆元}\ -z\text{）})\\
&= (y - z)_{\mathbb{C}}
&&(\because\ \blkref{def_real_difference}\ \text{を右辺から左辺へ})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明）: 原文（Typst）に対応ブロックは無い。exponential_series_of_even_odd_power_terms の証明の準備にあった同じ 6 行の鎖を主張にし、factorization_of_A_theta_general の Step 2・3 の末尾（ℂ の式を def_A_theta の (1,1)・(2,2) 成分の実数の像へ移す段）からも引けるようにした。準備の 5 行目の根拠「real_inclusion_preserves_finite_sum を 2 項へ当てた」は、2 項の場合そのものの real_inclusion_preserves_sum にした。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 右辺の差を def_real_difference の差と書き、最後の行「実数の四則」（y + (-1)z = y - z）を、(-1)z を加法の逆元 -z にする行と def_real_difference を右辺から左辺へ当てる行に割った（6 等号から 7 等号）。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_minus_one_times_minus_one_is_one_in_cc",
    kind: "claim",
    title: { tex: String.raw`(-1_{\mathbb{C}})(-1_{\mathbb{C}})=1_{\mathbb{C}}` },
    labels: ["minus_one_times_minus_one_is_one_in_cc"],
    lean: ["Ising2D.complex_minus_one_mul_minus_one"],
    statement: [
      paragraph([
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb{C}}`),
        " の ",
        math(String.raw`r = -1`),
        "、",
        math(String.raw`1_{\mathbb{C}}`),
        " は同じ略記の ",
        math(String.raw`r = 1`),
        " である。左辺の積は ",
        ref("definition_of_cc"),
        " の積である。このとき",
      ]),
      displayMath(String.raw`(-1_{\mathbb{C}})(-1_{\mathbb{C}}) = 1_{\mathbb{C}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-1_{\mathbb{C}})(-1_{\mathbb{C}})
&= (-1)_{\mathbb{C}}\,(-1)_{\mathbb{C}}
&&\bigl(\because\ -1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = -1\bigr)\\
&= \bigl((-1)(-1)\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to -1,\ b \to -1)\bigr)\\
&= (1)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-1)(-1) = 1\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = 1\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明）: 原文（Typst）に対応ブロックは無い。matrix_double_negation の鎖と V1_in_Z_Y_epsilon の Step 0 が ℂ の (-1_ℂ)(-1_ℂ) = 1_ℂ を definition_of_cc の積の名前で根拠にしており、exp_of_negative_i_real_as_cos_minus_i_sin の 2 行目を割るにも -(-b) = b に要るので、主張にして引けるようにした。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_one_plus_one_is_two_in_cc",
    kind: "claim",
    title: { tex: String.raw`1_{\mathbb{C}}+1_{\mathbb{C}}=2_{\mathbb{C}}` },
    labels: ["one_plus_one_is_two_in_cc"],
    lean: ["Ising2D.complex_one_add_one", "Ising2D.complex_one_add_one_eq_ofReal_two"],
    statement: [
      paragraph([
        math(String.raw`1_{\mathbb{C}}`),
        "・",
        math(String.raw`2_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb{C}}`),
        " の ",
        math(String.raw`r = 1`),
        "・",
        math(String.raw`r = 2`),
        " である。左辺の和は ",
        ref("definition_of_cc"),
        " の和である。このとき",
      ]),
      displayMath(String.raw`1_{\mathbb{C}} + 1_{\mathbb{C}} = 2_{\mathbb{C}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}} + 1_{\mathbb{C}}
&= (1)_{\mathbb{C}} + (1)_{\mathbb{C}}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = 1\ \text{を 2 か所へ}\bigr)\\
&= (1 + 1)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to 1,\ b \to 1)\bigr)\\
&= (2)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_real_two}\ \text{を右辺から左辺へ}\bigr)\\
&= 2_{\mathbb{C}}
&&\bigl(\because\ 2_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = 2\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明）: 原文（Typst）に対応ブロックは無い。matrix_sum_with_itself_zero_implies_zero・V1_plus_square_root_property・trace_of_check_number_operator_product・exp_of_negative_i_real_as_cos_minus_i_sin の証明の準備が同じ 4 行の鎖をそれぞれ置いていたので、minus_one_times_minus_one_is_one_in_cc と同じく主張にして引けるようにした。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p51d)。「ℝ で 1 + 1 = 2」の名前だけの根拠の件）: 3 行目 (1 + 1)_ℂ = (2)_ℂ の根拠「ℝ で 1 + 1 = 2」は名前だけだったので、ℝ の 2 を定める def_real_two を右辺から左辺へ当てる参照に替えた（式の両端と主張は不変）。",
      ],
    },
  },
  {
    id: "calc_formulae_009_sqrt_minus_one",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/009_definition_sqrt_minus_1.typ", ordinal: 10 },
    title: { tex: "\\sqrt{-1}" },
    labels: [],
    statement: [
      displayMath("\\sqrt{-1}:=\\sqrt{-1_{\\mathbb{C}}}"),
    ],
  },
]);
