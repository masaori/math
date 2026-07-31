# cycle 19 step 3（T3 Pure）: $\pi_{\mathrm{tr}}(p,k)$ の閉形式・$w^*$ の代数的記述・命題 C′ の Lean 化

**日付**: 2026-08-01 / **track**: T3 Pure / **step**: `trace_period_closed_form_and_lean_prop_C`
**数値検証**: `sagemath/check/cycle19_T3_trace_period/`（SageMath 10.6、FAIL 0、未決定 0）
**Lean**: `lean/IntegrableLattice/PropCTracePeriod.lean`（`lake build` 8668 jobs、`check-no-sorry.sh` 107 定理が sorryAx 非依存）

## 0. 結論（先に）

cycle 18 step 2 §7.2 が残した未解決 4 点のうち **3 点が決着し、1 点（$w^*$ の代数的記述）は
閉じた公式が得られた**。加えて cycle 18 の主定理が最良でなかったことが分かり、**本文を強化した**。

| cycle 18 §7.2 の未解決 | 本 step の結果 |
|---|---|
| (iii) 予想 A（隙間 $w^*+1\le k\le2w^*$ の階段） | **証明した**（定理 A′）。数値支持どまりだった主張が定理になった。証明は 5 行で、cycle 18 の定理 10 の評価が粗かっただけだった |
| (i) $\pi_{\mathrm{tr}}(p,k)=p^{e_k}\pi(p,1;S)$ の指数列 $(e_k)$ の閉じた公式 | **存在しないことを反例つきで確定させた**。$e_k$ を決める完全な構造式（定理 S）は得たが、その入力 $g_0$ は Wieferich 型の量で固有値データからは決まらず、増分も一定でない。反例 $T=(3)$, $p=2$（$w^*=0$ なのに $t_2=t_3$） |
| (ii) $w^*$ を代数的不変量で書けるか | **書けた**（定理 W）。$w^*=\min\{j:p^j\eta^{-1}\in A_{(p)}\}$、$\eta=(\chi'/(\chi/\rho))(\theta)$。$p$ 極大なら差積・分岐指数で $w^*=\max_{\mathfrak p\mid p}\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$。Smith 標準形を計算しなくてよい |
| (iv) 命題 C′ の Lean 化 | **形式化した**。本文の主張に**誤りは見つからなかった**（cycle 18 の命題 T と同じ「食い違いなし」型の決着）。ただし**過剰仮定を 2 件検出**した（下記 §1） |

**最大の成果は (iii) と、その副産物である主定理の強化である。**

$$\boxed{\ \pi_{\mathrm{tr}}(p,k)\ \bigm|\ p^{\,\max(k-w^*-1,\,0)}\,\pi_{\mathrm{tr}}(p,\,w^*+1)\qquad(k\ge1)\ }$$

cycle 18 の定理 7 は指数が $p^{k-1}$ だった。$w^*\ge1$ のとき本結果は真に強い。

**$\mathbb{R}$ にも $\mathbb{Z}_p$ にも脱出しない。** 本 step の証明は $\mathbb{Z}$ 上の
線形代数と、$\mathbb{Q}$ 上のエタール代数（$\overline{\mathbb{Q}}$ の代数的数）だけで閉じる。
$p$ 進の言葉（差積・分岐指数）は $\mathbb{Q}_p$ ではなく**数体の素イデアル**として使う（§4.3）。

**新規性は主張しない。** 線形漸化列の周期・トレース双対（Euler の双対基底公式）・差積は古典である。
本 step の内容は cycle 18 で自分たちが立てた主張の強化と、不変量の同定である。

## 1. Lean 化で分かったこと（(iv)。目的は主張の検算）

`lean/IntegrableLattice/PropCTracePeriod.lean`。**本文（`paper_prop_C_trace`）の主張と
形式化の間に食い違いは無かった。** cycle 17（命題 B）・cycle 18（命題 N・W）は誤りを検出したが、
今回は cycle 18 の命題 T と同じ「食い違いなし」型の決着である。代わりに次の 2 点が分かった。

### 1.1 定理 A′ の証明に $p$ の素数性は要らない

形式化した `traceOrth_one_add_pow` は `p` が素数であることを一切使っていない。
効いているのは二項係数のうち $\binom{p}{1}=p$ だけであり、$\binom{p}{i}$ が $p$ で割れることも
使わない。素数性が必要なのは $\pi_{\mathrm{tr}}(p,k)$ の定義（$p$ 進レベル）と Smith 標準形の段であって、
**階段の段ではない**。人手証明ではこの区別が付いていなかった。

### 1.2 「周期」の最小性は使っていない

人手証明は $t=\pi_{\mathrm{tr}}(p,k)$ を**最小**周期として導入するが、証明で使うのは
「$t$ が周期である」ことだけである。形式化では `IsTracePeriodAt`（最小性を要求しない述語）で
述べるほかなかった。**最小性を仮定に入れると `isTracePeriodAt_mul_prime` は述べられない**
（結論の $pt$ は最小とは限らない）。人手証明が最小性を使っていないことは、この形式化で確認できる。

### 1.3 形式化した主張

| Lean 定理 | 対応する人手証明 |
|---|---|
| `TraceOrth` / `IsTracePeriodAt` | 「$t$ はトレース列の $\bmod p^k$ の周期」の内容 |
| `traceOrth_of_forall_pow` | $x=S^N$ の条件から全ての $x\in\mathbb{Z}[S]$ の条件を出す段（人手証明は暗黙に使っていた） |
| `dvd_of_mulVec_dvd` | **定理 6 の Smith 標準形の段**。$HG=p^{w}I$ から $Gb\equiv0\ (p^k)\Rightarrow p^{k-w}\mid b_j$ |
| `traceOrth_one_add_pow` | **定理 A′ の心臓部**（§2） |
| `isTracePeriodAt_mul_prime` | 定理 A′ 本体（$t_{k+1}\mid p\,t_k$） |
| `luc_add_three` / `lucas_two_power_not_period` | **命題 12 の反例**（$T=F\oplus F$, $p=2$）。レベル 1 では周期 1 なのにレベル 2 では $2$ 冪はどれも周期にならない |
| `orderOf_three_zmod_*` / `trace_period_not_affine` | **閉形式の不存在の反例**（$T=(3)$, $p=2$） |

$R=\mathbb{Z}[S]$ を「1 元で生成される可換環」、$\operatorname{Tr}$ を「$\mathbb{Z}$ への加法準同型」へ
**抽象化して**形式化した。人手証明が使っているのはこの 2 性質だけであること自体が検算になっている。

### 1.4 形式化していない主張と、その理由（一次情報で確認済み）

**mathlib に「無い」と書く前に検索した**（cycle 16 の偽陰性事故を踏まえた 3 段方式。
ログ `lean/logs/mathlib-gap-survey-cycle19.log`、mathlib `520045ab14`、走査 8264 ファイル）。

- **定理 W は形式化していない。** ただし **mathlib には材料が在る**:
  `Mathlib/RingTheory/DedekindDomain/Different.lean` に `traceDual`（100 行目 `traceDual_span_of_basis`）・
  `differentIdeal`・`aeval_derivative_mem_differentIdeal`（673 行目）・
  `conductor_mul_differentIdeal`（633 行目）が実在する。**「無い」のではない。**
  無いのは (a) これらを「重み付きトレース形式の Gram 行列の最大単因子」へ結ぶ配線と、
  (b) **整数行列の単因子**（mathlib の `Basis.SmithNormalForm` は部分加群の基底の形で与えられ、
  行列の単因子としては与えられていない）である。
  本ファイルは Smith 標準形を**使わず**、その帰結（$HG=p^wI$ なる整数行列 $H$ の存在）を
  仮定として型に出すことで、$w^*$ の使われ方だけを検算した。
- **$\pi_{\mathrm{tr}}$ そのものの最小性・純周期性**は `PropCPeriod.lean` の
  `isUnit_pow_add_eq_iff` と同じ方式で扱えるが、本 step の主張には不要なので入れていない。

**ビルド**: `lake build` **8668 jobs 成功**（cycle 18 は 8667）。
`scripts/check-no-sorry.sh`: 列挙した **107 個**の定理がいずれも `sorryAx` 非依存（cycle 18 は 85）。
ログ: `lean/logs/build-cycle19-propC.log`, `lean/logs/check-no-sorry-cycle19.log`。

## 2. (iii) 予想 A の証明 — 定理 A′

記号は cycle 18 step 2 を継承する（`outputs/reports/cycle18_T3_trace_period_bound.md` §1）。
$R=\mathbb{Z}[S]$ は $I,S,\dots,S^{r-1}$ を $\mathbb{Z}$ 基底とする階数 $r$ の自由 $\mathbb{Z}$ 加群である。

**定理 A′.** $k\ge w^*+1$ ならば $\pi_{\mathrm{tr}}(p,k+1)\mid p\,\pi_{\mathrm{tr}}(p,k)$。

*証明.* $t=\pi_{\mathrm{tr}}(p,k)$、$B=S^t-I\in R$ とおく。

1. $t$ はトレース列の周期だから、**全ての $x\in R$** で
   $\operatorname{Tr}(xB)\equiv0\pmod{p^k}$（$x=S^N$ で成り立ち、$R$ は $S$ の $\mathbb{Z}$ 係数
   多項式全体だから線形性で従う）。
2. cycle 18 の定理 6 の証明より、$k>w^*$ なら $B=p^{\,k-w^*}C$（$C\in R$）と書ける。
3. $S^{pt}-I=(I+B)^p-I=\sum_{i=1}^{p}\binom{p}{i}B^i$ の各項を $x\in R$ とのトレースで評価する。
   - $i=1$: $\operatorname{Tr}(x\cdot pB)=p\operatorname{Tr}(xB)$ なので $v_p\ge k+1$。
   - $i\ge2$: $B^i=B\cdot(p^{\,k-w^*}C)^{i-1}=p^{(i-1)(k-w^*)}\,C^{\,i-1}B$ だから
     $$\operatorname{Tr}(xB^i)=p^{(i-1)(k-w^*)}\operatorname{Tr}\bigl((xC^{\,i-1})B\bigr),$$
     そして $xC^{\,i-1}\in R$ なので右の因子は $p^k$ で割れる。よって
     $v_p\ge k+(i-1)(k-w^*)\ge k+1$（$k-w^*\ge1$, $i-1\ge1$）。
4. ゆえに全ての $N$ で $\operatorname{Tr}(S^N(S^{pt}-I))\equiv0\pmod{p^{k+1}}$、すなわち $pt$ は
   レベル $k+1$ の周期。最小周期はこれを割る。∎

**cycle 18 の定理 10 が $k\ge2w^*+1$ でしか出せなかった理由。** そこでは $B^i$ を
「$p^{i(k-w^*)}$ で割れる」とだけ評価していた。その評価は $B$ の $i$ 個すべてを $p$ 冪として使うので
$i(k-w^*)\ge k+1$、つまり $k\ge2w^*+1$ を要求する。**本証明の要点は、$i$ 個のうち 1 個を
トレース直交性のために残し、残り $i-1$ 個だけを $p$ 冪として使うことである。**
これで要求は $(i-1)(k-w^*)\ge1$ に落ち、しきい値が $w^*+1$ になる。

**しきい値 $w^*+1$ は最良である**（$k\le w^*$ では偽。cycle 18 の X2low で $70/514=13.6\%$ が破れる）。

**系 A″（改良した主定理）.** すべての $k\ge1$ で
$$\pi_{\mathrm{tr}}(p,k)\ \bigm|\ p^{\,\max(k-w^*-1,\,0)}\,\pi_{\mathrm{tr}}(p,\,w^*+1).$$

*証明.* $k\le w^*+1$ なら単調性（cycle 18 命題 4）。$k>w^*+1$ なら定理 A′ を
$w^*+1,\dots,k-1$ で $k-w^*-1$ 回使う。∎

**指数はこれ以上下げられない**（§5 の Y3: 5544 件中 3111 件で $p^{k-w^*-2}$ 版が破れる）。
たとえば $T=F\oplus F$, $p=2$ では $t_k=1,3,6,12,24,48$、$w^*=1$ で
$t_6=48=2^{4}\cdot t_2=2^{6-1-1}\cdot3$ ちょうどである。

## 3. (i) 閉形式は存在しない — 構造定理と反例

### 3.1 $e_k$ を完全に決める構造式（定理 S）

$\tau=\pi(p,1;S)$ とおく。cycle 18 の系 11 より $k>w^*$ では $t_k=p^{e_k}\tau$ である。

**定理 S.** $g_m:=\min_{0\le N<r}v_p\bigl(\operatorname{Tr}(S^N(S^{p^m\tau}-I))\bigr)$
（$\in\mathbb{N}\cup\{\infty\}$）とおくと、$k>w^*$ で
$$e_k=\min\{m\ge0:\ g_m\ge k\}.$$

*証明.* $p^m\tau$ がレベル $k$ の周期であることと $g_m\ge k$ は定義から同値である
（$\operatorname{Tr}(S^Nx)$ は $\rho$ のモニック漸化式を満たすので、$N<r$ の検査で全 $N$ について必要十分）。
$t_k=p^{e_k}\tau$ が最小周期だから $t_k\mid p^m\tau\iff e_k\le m$。∎

**定理 A′ の $g$ 版.** $g_m\ge w^*+1$ なら $g_{m+1}\ge g_m+1$。より精密に
$g_{m+1}\ge\min(g_m+1,\ 2g_m-w^*)$（§2 の評価をレベル $g_m$ で回すだけ）。

したがって $g$ が一度 $w^*$ を超えれば、**$g_m$ は少なくとも 1 ずつ増える**。
もし増分がちょうど 1 なら $g_m=g_0+m$ となり
$$e_k=\max(0,\ k-g_0)$$
という閉形式が出る。**問題はこれが成り立たないことである。**

### 3.2 閉形式が存在しないことの 2 つの障害

**障害 1: $g_0$ は固有値データから決まらない。** $r=1$（$T=(c)$）のとき
$g_0=v_p(c^{\tau}-1)$、$\tau=\mathrm{ord}_p(c)$ である。これは Fermat 商の付値であり、
$g_0\ge2$ になる $(c,p)$ は Wieferich 型の稀な現象で、$c$ と $p$ から初等的な式では書けない
（$c=2$, $p=1093$ で $g_0=2$）。**$\chi_T$ の係数や固有値の代数的データからは決まらない。**

**障害 2: 増分は 1 とは限らない。** $g_{m+1}=g_m+1$ は Wall 型等式のトレース列版であり、
一般に**偽**である。最小の反例:

> $T=(3)$、$p=2$。$\chi=\rho=x-3$、$\eta=1$、$\det G=1$、**$w^*=0$**、$\tau=1$。
> $$g_m=(1,\,3,\,4,\,5,\,6,\,7,\,8),\qquad t_k=(1,2,2,4,8,16)\ (k=1..6),\qquad e_k=(0,1,1,2,3,4).$$
> $g_0=1$ から $g_1=3$ へ **2 段跳ぶ**（$v_2(3^2-1)=v_2(8)=3$）。ゆえに
> $e_k\ne\max(0,k-g_0)=(0,1,2,3,4,5)$ であり、$e_k\ne k-1$ でもある。

$w^*=0$（＝命題 C′ の上界が命題 C と同じ形になる最良の場合）でさえ閉形式が無いことに注意。
これは Lean で `trace_period_not_affine` として形式化した（$t_2=t_3$ かつ $t_3\ne t_4$）。

**結論（(i) の決着）**: $(e_k)$ は定理 S で**完全に決まる**が、その入力 $(g_m)$ は
「固有値データから決まる閉じた式」では書けない。**書けないことの障害は 2 つとも特定した**
（Wieferich 型の初期値と、Wall 型等式の不成立）。

障害 2 が住む場所について、**証明できていることと数値観察を分けて書く**:

- **証明済み**: $p$ が奇で $r=1$（$T$ がスカラー）なら LTE により $g_m=g_0+m$ が**厳密に成り立つ**。
  この領域には障害 2 は無い。
- **数値観察のみ**: 本標本の Y8 の反例 **553 件はすべて $p=2$** に出た
  （内訳 $(p,r)=(2,1)$: 153、$(2,2)$: 292、$(2,3)$: 96、$(2,4)$: 12。$p=2$ での破れ率 $553/1231=44.9\%$）。
  **奇素数 $p\in\{3,5\}$ では 3600 件の検査で反例 0 だが、これは「奇素数では破れない」の
  根拠にはならない。** 3600 件で 95% の検出力があるのは破れ率 $\ge0.083\%$ の場合までであり
  （$1-(1-q)^{3600}\ge0.95\iff q\ge0.00083$）、それ未満の稀な反例は本標本では検出できない。
  また $r\ge2$・奇 $p$ で $g_m=g_0+m$ が常に成り立つかは**未証明**である。

**決定可能性は失われない。** $g_m$ も $t_k$ も有限環 $\mathbb{Z}/p^{k}$ 上の有限計算で決まる。
「閉形式が無い」は「決定できない」ではない。

## 4. (ii) $w^*$ の代数的閉形式 — 定理 W

### 4.1 主定理

$\chi=\chi_T=\prod_i f_i^{a_i}$、$\rho=\prod_i f_i$、$h=\chi/\rho\in\mathbb{Z}[x]$、
$A=\mathbb{Z}[x]/(\rho)$、$\theta=x\bmod\rho$ とおく。

**補題 W0.** $\chi'/h=\sum_i a_i f_i'\,\rho/f_i\in\mathbb{Z}[x]$ である。
$\eta:=(\chi'/h)(\theta)\in A$ とおくと、$A\otimes\mathbb{Q}=\prod_i K_i$（$K_i=\mathbb{Q}[x]/(f_i)$）
の成分 $i$ で $\eta=a_i\,\rho'(\theta_i)$ である。

*証明.* $\chi'/\chi=\sum_i a_i f_i'/f_i$ の両辺に $\rho$ を掛けると
$\chi'\rho/\chi=\chi'/h=\sum_i a_if_i'\,\rho/f_i$。各項は多項式である。
$\theta_i$ で評価すると $j\ne i$ の項は因子 $f_i(\theta_i)=0$ を含むので消え、
残るのは $a_if_i'(\theta_i)\prod_{j\ne i}f_j(\theta_i)=a_i\rho'(\theta_i)$。∎

**定理 W.** $$w^*=\min\{\,j\ge0:\ p^{\,j}\eta^{-1}\in A_{(p)}\,\},\qquad \det G=\pm N_{A/\mathbb{Q}}(\eta).$$

*証明.* $\operatorname{Tr}T^N=\sum_\lambda m_\lambda\lambda^N
=\operatorname{Tr}_{A_\mathbb{Q}/\mathbb{Q}}(\mu\,\theta^N)$、ここで $\mu\in A_\mathbb{Q}$ は
成分 $i$ で $a_i$ を取る元である。したがって $G$ は双線型形式
$\langle x,y\rangle=\operatorname{Tr}_{A_\mathbb{Q}/\mathbb{Q}}(\mu xy)$ の基底
$1,\theta,\dots,\theta^{r-1}$ に関する Gram 行列である。
$\rho$ は分離的（相異なる既約因子の積）なので $A_\mathbb{Q}$ はエタール代数であり、
**Euler の双対基底公式**より、通常のトレース形式に関する双対格子は $A^\vee=\rho'(\theta)^{-1}A$ である。
重みを入れると $\langle\cdot,\cdot\rangle$ に関する双対は $\mu^{-1}A^\vee=\eta^{-1}A$（補題 W0）。

Gram 行列の余核は双対格子の商だから
$\operatorname{coker}(G)\cong\eta^{-1}A/A\cong A/\eta A$。
ゆえに $G$ の単因子は有限アーベル群 $A/\eta A$ の不変量に等しい。最大単因子の $p$ 進付値を取れば
$w^*=\min\{j: p^jA\subseteq\eta A\ \text{（$p$ で局所化して）}\}=\min\{j:p^j\eta^{-1}\in A_{(p)}\}$。
行列式を取れば $\det G=\pm|A/\eta A|=\pm N_{A/\mathbb{Q}}(\eta)$。∎

**cycle 18 の補題 2 との整合**: $N(\eta)=N(\mu)N(\rho'(\theta))=\bigl(\prod_i a_i^{\deg f_i}\bigr)\cdot
\pm\operatorname{disc}(\rho)$ であり、cycle 18 の $\det G=\operatorname{disc}(\rho)\prod_\lambda m_\lambda$ と一致する。

### 4.2 分岐データによる表示

**系 W2.** $\rho$ が既約で $A=\mathbb{Z}[\theta]$ が $p$ 極大なら、$K=\mathbb{Q}[x]/(\rho)$ の
$p$ 上の素イデアル $\mathfrak p$ について
$$w^*=\max_{\mathfrak p\mid p}\Bigl\lceil\frac{v_\mathfrak p(\eta)}{e_\mathfrak p}\Bigr\rceil,
\qquad v_\mathfrak p(\eta)=e_\mathfrak p\,v_p(a)+d_\mathfrak p,$$
ここで $a$ は $\rho$ の $\chi$ における重複度、$d_\mathfrak p$ は差積指数、$e_\mathfrak p$ は分岐指数である。

*証明.* $p$ 極大なら $A_{(p)}$ は Dedekind で、$p^j\eta^{-1}\in A_{(p)}$ は各 $\mathfrak p\mid p$ で
$j\,e_\mathfrak p\ge v_\mathfrak p(\eta)$ と同値。$v_\mathfrak p(\rho'(\theta))=d_\mathfrak p$（差積の定義）。∎

**読み方**（(ii) が求めていた「Newton 多角形・分岐データ」での記述）:

- **不分岐（$d_\mathfrak p=0$）かつ $p\nmid a$ ⟺ $w^*=0$** — cycle 18 の系（$w^*=0$ の特徴づけ）と一致する。
- **従順分岐**（$p\nmid e_\mathfrak p$）なら $d_\mathfrak p=e_\mathfrak p-1$ なので
  $\lceil d_\mathfrak p/e_\mathfrak p\rceil=1$（$e_\mathfrak p\ge2$）。**従順分岐は $w^*$ を 1 しか上げない。**
- **暴分岐**（$p\mid e_\mathfrak p$）では $d_\mathfrak p\ge e_\mathfrak p$ になり得て $w^*$ が大きくなる。
  標本で $w^*=7$ まで観測されるのはこの寄与と $v_p(a)$ の寄与である。
- $\rho$ が可約なら $v_\mathfrak p(\eta)$ に $\sum_{j\ne i}v_\mathfrak p(f_j(\theta))$（**相異なる既約因子の
  $\bmod p$ での「のり付け」**）が加わる。定理 W はこの場合も**そのまま成り立つ**（$\eta$ に自動的に入る）。

**実用上の意味**: $w^*$ の計算に Smith 標準形は要らない。$\chi$ から $\eta$ を作り、
$\eta^{-1}$ の座標の分母の $p$ 冪を見ればよい（$r\times r$ の 1 回の連立一次方程式）。

### 4.3 可算性の明示

登場するのは $\mathbb{Z}$ の元・$\mathbb{Z}$ 係数多項式・$\mathbb{Q}$ 上有限次のエタール代数
$A_\mathbb{Q}$（＝$\overline{\mathbb{Q}}$ の中の可算な対象）・有限環 $\mathbb{Z}/p^k$ だけである。
**$\mathbb{R}$・$\mathbb{C}$・$\mathbb{Z}_p$・$\mathbb{Q}_p$ は使わない。**
系 W2 の $v_\mathfrak p$・$d_\mathfrak p$・$e_\mathfrak p$ は $\mathbb{Q}_p$ の付値ではなく
**数体 $K$ の素イデアルに付随する（可算な）データ**であり、`sage` でも
`K.primes_above(p)` と `K.ideal(...).valuation(P)`（イデアル論）で計算している。

## 5. 数値検証

コード: `sagemath/check/cycle19_T3_trace_period/trace_period_closed_form.sage`
（SageMath 10.6、seed 固定で再現可能）。ログ: 同ディレクトリ `trace_period_closed_form.out`。
標本 **927 組**（random 385 + degenerate-enriched 506 + スカラー・named 36）、$k=1..6$、$m=0..6$。

| ID | 内容 | 検査数 | 非自明 | 反例 | 期待 |
|---|---|---:|---:|---:|---|
| W1 | $w^*=\min\{j:p^j\eta^{-1}\in A_{(p)}\}$（定理 W） | 927 | 316 | **0** | 0 |
| W2 | $\det G=\pm N(\eta)$（定理 W） | 927 | 927 | **0** | 0 |
| W3 | $p$ 極大なら $w^*=\max_\mathfrak p\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$（系 W2） | 655 | 184 | **0** | 0 |
| **Y1** | **$k\ge w^*+1\Rightarrow t_{k+1}\mid p\,t_k$（定理 A′）** | **4115** | **4115** | **0** | 0 |
| **Y2** | **$t_k\mid p^{\max(k-w^*-1,0)}t_{w^*+1}$（系 A″）** | **5544** | **4115** | **0** | 0 |
| Y3 | 指数をもう 1 下げる | 5544 | 4115 | **3111** | 反例が出るべき |
| Y4 | $e_k=\min\{m:g_m\ge k\}$（定理 S） | 5039 | 5039 | **0** | 0 |
| Y5 | $g_m\ge w^*+1\Rightarrow g_{m+1}\ge g_m+1$ | 4621 | 4621 | **0** | 0 |
| Y6 | $g_{m+1}\ge\min(g_m+1,2g_m-w^*)$ | 4831 | 4831 | **0** | 0 |
| Y7 | $e_k=\max(0,k-g_0)$（閉形式の候補） | 5039 | 5039 | **325** | 反例が出るべき |
| Y8 | $g_{m+1}=g_0+m+1$（Wall 型等式） | 4831 | 4831 | **553** | 反例が出るべき |

**証明済みの主張 8 種で失敗 0 件、打ち切りによる未決定 0 件。**
「反例が出るべき」3 種はいずれも反例が出た（検査系が反例を検出できることの確認）。

### 5.1 証明したことと数値支持どまりのことの区別

**本 step が報告する主張はすべて証明済みであり、数値だけを根拠にした主張は 1 つも無い。**

- 定理 A′・系 A″・定理 S・定理 W・系 W2 はいずれも §2–§4 に証明がある。
  数値検証は「証明とコードが独立に整合している」ことの確認であって、主張の根拠ではない。
- cycle 18 §7.1 の予想 A は**数値支持どまりだった**（402 件・破れ率 0.74% までしか検出力が無いと
  明記されていた）。本 step でそれが定理 A′ になったので、**この主張はもう数値支持ではない**。
- 「閉形式は存在しない」は否定的主張だが、**反例 1 個（$T=(3)$, $p=2$）で確定する**ので
  数値支持どまりではない（Lean でも形式化した）。

**数値支持どまりの観察が 1 件だけある**（主張としては立てない）:
奇素数 $p\in\{3,5\}$ では Y8（Wall 型等式）の反例が 3600 件の検査で 0 件だった。
$r=1$ の場合は LTE で証明できるが、$r\ge2$ の場合は**未証明**である。
本標本の検出力は破れ率 $\ge0.083\%$ までなので、稀な反例は検出できない（§3.2）。

$g_m$ の cap（$g_m\ge30$）が 856 件あるが、これはトレース列が $p^m\tau$ でちょうど完全周期になる
場合であり、cap 水準 30 が $k\le6$ よりはるかに大きいので**判定できなかった検査は 0 件**である。

## 6. 自分の誤り（隠さず記録する）

1. **最初、定理 A′ のしきい値を $w^*$ と書いた。** §2 の評価は $k-w^*\ge1$ すなわち
   $k\ge w^*+1$ を要求するのに、$k\ge w^*$ で十分と誤記した。
   $T=F\oplus F$, $p=2$（$w^*=1$）の $t_1=1,t_2=3$ で $t_2\nmid 2t_1=2$ となり、
   数値検証の 1 回目で露見した。しきい値を $w^*+1$ に直した。
2. **定理 W の検算コードで $p$ 極大性の判定を誤った。**
   `K.maximal_order().index_in(K.order(K.gen()))` は 1 未満の有理数を返すので `ZZ(...)` が例外を投げた。
   $\operatorname{disc}(f)=[\mathcal{O}_K:\mathbb{Z}[\theta]]^2\operatorname{disc}(K)$ を使う形に直した。
   この誤りは数学的主張には影響していない（コードの誤り）。
3. **Lean で「mathlib にトレース双対が無い」と書きかけた。** 実際には
   `Mathlib/RingTheory/DedekindDomain/Different.lean` に `traceDual`・`differentIdeal` が実在する。
   §1.4 のとおり grep で確認してから書き直した（cycle 16 の偽陰性事故と同型になりかけた）。

いずれも「証明を数値で確かめる」「無いと書く前に検索する」手順を先に回したから見つかった。

## 7. 論文本文への反映

`structured-latex/content/004_lambda_finite.ts` に**新規ブロックを 2 つ追加**した
（既存ブロックの整形・並べ替えはしていない）。

- **命題 C″**（ラベル `paper_prop_C_trace_ladder`）: 定理 A′・系 A″・定理 S・閉形式の不存在。
  `verification` は `sagemath/check/cycle19_T3_trace_period`、`lean` に 5 定理。
- **命題 W\***（ラベル `paper_wstar_different`）: 定理 W と系 W2。

既存の**命題 C′ には 1 段落だけ追記**した（「この上界は最良ではない」と 2 つの新ブロックへの参照）。
命題 C′ の主張自体は正しいので撤回・訂正はしていない。

## 8. 残っている未解決

- **$g_0$（トレース水準の初期値）を代数的データで書くこと。** §3.2 の障害 1。
  $r=1$ では Fermat 商の付値そのものなので、一般に閉じた式は期待できない。
  ただし「どの $(T,p)$ で $g_0\ge2$ になるか」を Wieferich 型条件として特徴づけることは
  未着手であり、可能性はある。
- **増分が 2 以上になる $(T,p)$ の特徴づけ**（§3.2 の障害 2）。$p=2$ と $r\ge2$ に分布することは
  観測したが、条件は得ていない。
- **定理 W の Lean 化**（§1.4）。mathlib の `traceDual`／`differentIdeal` と、
  行列の単因子との配線が要る。
- cycle 18 から引き継いだ他の未解決（$\theta\ge\ell+1$ の退化塔、$\theta=\infty$、$d\ge3$ の低位項）は
  本 step の対象外（cycle 19 の step 1・step 2）。
