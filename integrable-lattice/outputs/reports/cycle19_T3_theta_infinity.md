# cycle 19 / T3 Pure: 消滅深度が無限大の場合（$\theta=\infty$）の処理と、型 III の odd $\ell$ 族

対象: cycle 18（`outputs/reports/cycle18_T3_general_degenerate_tower.md`）§4.5 が
**第 3 の破れ方**として例だけ挙げ、§6.2 が「段階的な処理が考えられるが着手していない」と
書いて終わっている場合 — すなわち**消滅深度 $\theta$ が無限大**（方向上で $\bar E$ が恒等的に消える）
場合を扱う。

前提として読んでいる一次情報:
`cycle18_T3_general_degenerate_tower.md`（補題 A1–A5、定理 B、定理 C、命題 F・G、§4.3–§4.5、§6.2）、
`cycle17_T3_degenerate_torus_odd_ell.md`、
`cycle16_T3_lower_order_and_degeneracy.md`（定理 D1・D2、§7 の型 I/II/III 分類）、
`cycle14_T3_two_variable_criterion.md`（$(1.1)$）。

記号は cycle 18 §1 をそのまま引き継ぐ。$X$ は有限連結 voltage 多重グラフ、$\alpha:E\to\mathbb{Z}^2$、
$L(z,w)$ は voltage ラプラシアン、$D=\det L$、$\mu=v_\ell(\mathrm{content}\,D)$、$E=\ell^{-\mu}D$、
$g(T,S)=E(1+T,1+S)$、$k=\mathrm{ord}(\bar g)$、$H$ は最低次斉次部分、$z_H=|Z_H|$、
$\kappa_n=\kappa(X_{\ell^n,\ell^n})$、仮定 **(H)** を通して置く。cycle 14 $(6.1)$ より

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu(\ell^{2n}-1)+\Sigma_n,\qquad
\Sigma_n=\sum_{\substack{\zeta^{\ell^n}=\xi^{\ell^n}=1\\(\zeta,\xi)\neq(1,1)}}v_\ell\bigl(E(\zeta,\xi)\bigr).\tag{1.1}$$

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| **定理 S**（段階的処理）: $\Phi_{(a,b)}$ の**内容を 1 回割るだけ**で $\theta=\infty$ は解消し、$\theta^*<\infty$ が必ず得られる。仮定 $\theta^*-m_1<\varphi(\ell^M)$ の下で $v_\ell(E(\zeta,\xi))=\lambda+\theta^*/\varphi(\ell^M)$ | **証明した**（§2.3）。cycle 18 §6.2 が「考えられる」と書いた段階的処理は**機能する。しかも反復不要で 1 段で閉じる** |
| **命題 2**（判定条件）: $u$ 原始のとき $\lambda(u)\ge1\iff(\chi^{u^\perp}-1)\mid\bar{\tilde E}$（$u^\perp=(b,-a)$） | **証明した**（§3.1）。$\ker\psi_u$ が単項イデアルであることによる |
| **命題 3**（有限性）: そのような $u^\perp$ は $\mathrm{Newt}(\bar{\tilde E})$ の Minkowski 因子。よって**$\theta=\infty$ の軌跡は原点を通る有限本の直線の合併**で、$D$ の係数からの有限計算で完全に決まる | **証明した**（§3.2）。Ostrowski（Newton 多面体の加法性） |
| **系 5**（同居構造）: 方向 $P$ のレベルちょうど $M$ の点 $(\ell-1)\ell^{2M-2}$ 個のうち、例外直線に乗るのは**直線ごとに $\varphi(\ell^M)$ 個ちょうど**。割合は $\ell^{1-M}$ | **証明した**（§4.1）。cycle 18 §4.5 が「同居」と呼んだ現象の正体 |
| **系 6**: 例外直線を持つ方向では一般点も $\theta\ge\ell+1$。すなわち $\theta=\infty$ の塔は**必ず** cycle 18 定理 C の射程外（逆は偽） | **証明した**（§4.2） |
| **命題 7**: 例外直線 1 本の $\Sigma_n$ への寄与は $\lambda(\ell^n-1)+n\theta^*$。**$n\ell^n$ 項を作らない** | **証明した**（§4.3） |
| **命題 8**（族の完全分類）: bouquet $p(1,0)+q(0,1)$ で $\theta=\infty\iff\ell\mid p'q'(p'+q')$、例外直線と $\lambda$ も明示 | **証明した**（§5.1） |
| **定理 X**（族の点ごとの付値）: 上の族で $\ell$ 奇なら**全レベル・全点**の $v_\ell(E)$ が閉形式で決まる | **証明した**（§5.2） |
| **定理 X′**（族の閉形式）: $\Lambda:=\sum_{\text{例外直線}}\lambda$ として、**全ての $n\ge0$** で $$\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^{n}+\Lambda(\ell^{n}-1)$$ | **証明した**（§5.3）。**本サイクルの主結果** |
| **系 X″**: この族は**任意の奇素数 $\ell$ で型 III**（$n\ell^n$ の係数 $b=2\neq0$）。cycle 16・17 で型 III の実例は $\ell=2$ のトーラス 1 件だけだった | **証明した**（§5.4） |
| **命題 9**（被覆）: $\ell$ 奇ならこの族の塔は**全て**（非退化 / cycle 18 定理 C / 定理 X′）のどれかに入る | **証明した**（§5.5） |
| $n\ell^n$ 項の出所は $\theta=\infty$ の点**ではなく**その $\ell$ 進近傍 | **証明した**（命題 7 ＋ §5.3 の内訳） |
| 定理 X′ の形（$\mu(\ell^{2n}-1)+kn\ell^n+\Lambda(\ell^n-1)+v_\ell(\kappa_X)$）を一般の塔へ延長すること | **反例で否定した**（§9.1）。$\ell=3$ の bouquet $(1,0),(1,-1),(1,2)$ 等 |
| $\theta\ge\ell+1$ かつ例外直線なしの塔 | **本 step の対象外**（cycle 19 step 1 の担当） |
| 新規性 | **主張しない**（§10） |

**本 report に「数値だけで支持している主張」は 1 件も無い**（§7 に根拠を書く）。
§6 の分類件数は宣言した母集団の**全走査**であり、標本抽出ではない。

---

## 1. 出発点（cycle 18 が残した第 3 の破れ方）

cycle 18 補題 A5: $\tilde E=z^rw^sE\in\mathbb{Z}[z,w]$、$\Phi_{(a,b)}(x):=\tilde E((1+x)^a,(1+x)^b)\in\mathbb{Z}[x]$
とすると $\Phi_{(a,b)}=\sum_m A_m(a,b)x^m$ で、消滅深度は
$\theta(a,b)=\mathrm{ord}_{x=0}\overline{\Phi_{(a,b)}}\in\mathbb{F}_\ell[x]$ である。
とくに $\theta(a,b)=\infty\iff\overline{\Phi_{(a,b)}}\equiv0$。

cycle 18 §4.5 の例（本 report でも中心に据える）: $\ell=5$、$X$ は 1 頂点 5 ループ、
voltage は $(1,0)$ が 4 本と $(0,1)$ が 1 本。$E=D=4(2-z-z^{-1})+(2-w-w^{-1})$、$\mu=0$。
$(a,b)=(1,1)$ で $\bar E((1+x),(1+x))=5(2-(1+x)-(1+x)^{-1})\equiv0$ なので $\theta(1,1)=\infty$。
一方 $(a,b)=(1,6)$（同じ方向 $(1{:}1)$、レベル 2）では $\theta=6<\infty$。
cycle 18 はこの**同居**を「$M$ 依存の具体的な姿」と述べたが、構造は特定していない。

本 report は次の 3 つを行う。

1. §6.2 が挙げた段階的処理が実際に機能するかを確かめ、機能するなら閉形式を証明する（§2）。
2. 同居構造を付値の言葉で記述する（§3–§4）。
3. $\theta=\infty$ になる方向を判定する条件を確定させ、母集団に対して網羅的に分類する（§5–§6）。

---

## 2. 段階的処理は機能する（しかも 1 段で閉じる）

### 2.1 定義（1 変数への制限）

cycle 18 の $A_m$ は 2 変数のままの量だったが、$\theta=\infty$ を扱うには
**$\tilde E$ を 1 径数部分群へ制限した 1 変数 Laurent 多項式そのもの**を見るのが正しい。

> **定義 2.1.** $(a,b)\in\mathbb{Z}^2\setminus\{0\}$ に対し、環準同型
> $$\psi_{(a,b)}:\ \mathbb{Z}[z^{\pm1},w^{\pm1}]\longrightarrow\mathbb{Z}[y^{\pm1}],\qquad z\mapsto y^a,\ w\mapsto y^b$$
> を取り、$R_{(a,b)}:=\psi_{(a,b)}(\tilde E)\in\mathbb{Z}[y^{\pm1}]$ と置く。
> $y^{\text{(最低次)}}$ を落として $y=1+x$ と書き直したものが $\Phi_{(a,b)}(x)\in\mathbb{Z}[x]$ である
> （$a,b\ge0$ なら cycle 18 補題 A5 の $\Phi$ と一致する。$a$ や $b$ が負でも定義できる）。
> $\Phi_{(a,b)}\neq0$ のとき
> $$\lambda(a,b):=v_\ell\bigl(\mathrm{content}\,\Phi_{(a,b)}\bigr)\in\mathbb{N},\qquad
> \Psi_{(a,b)}:=\ell^{-\lambda}\Phi_{(a,b)}\in\mathbb{Z}[x],$$
> $\Psi=\sum_m B_mx^m$ として
> $$\theta^*(a,b):=\min\{m:\ \ell\nmid B_m\},\qquad
> m_1(a,b):=\min\{m<\theta^*:\ B_m\neq0\}\ (\text{無ければ}+\infty).$$

> **補題 2.2.** *$\Phi_{(a,b)}\neq0$ ならば $\theta^*(a,b)<\infty$ である。また*
> $$\theta(a,b)=\theta^*(a,b)\ \ (\lambda=0),\qquad \theta(a,b)=\infty\iff\lambda(a,b)\ge1.$$

**証明.** 内容を割った後の $\Psi$ は、係数の $\ell$ 進付値の最小値が $0$ なので $\bar\Psi\neq0$、
よって $\theta^*<\infty$。残りは定義そのもの。$\blacksquare$

**注 2.3（$\Phi_{(a,b)}=0$ の場合）.** $\tilde E$ が $\mathbb{Z}$ 上ですでに 1 径数部分群で消える場合で、
このとき $E(\zeta,\xi)=0$、$(1.1)$ の右辺が発散する。これは仮定 (H)（塔の全段が連結）が破れる場合に
あたるので、以下 (H) の下では起きない。

### 2.2 §6.2 が考えた処理との関係

cycle 18 §6.2 は「$E$ を $\ell$ で割って $E'=\ell^{-1}(\text{制限})$ を取り直す**段階的**な処理」を
挙げていた。定義 2.1 はまさにそれだが、**割るのは $E$ ではなく制限した 1 変数多項式**であり、
しかも**内容で 1 回割るだけで必ず終わる**（補題 2.2）。$\ell$ で 1 回ずつ割って反復する必要はない。
$\lambda$ が段数、$\theta^*$ が段階処理後の消滅深度である。

### 2.3 定理 S（段階的処理の下での点ごとの付値）

$\ell$ を素数、$M\ge1$、$g$ を原始 $\ell^M$ 乗根、$\pi=g-1$、$\alpha:=v_\ell(\pi)=1/\varphi(\ell^M)$ とする。

> **定理 S.** *$(a,b)\in\mathbb{Z}^2\setminus\{0\}$、$\zeta=g^a$、$\xi=g^b$、$(\zeta,\xi)\neq(1,1)$ とし
> $\Phi_{(a,b)}\neq0$ とする。$\lambda=\lambda(a,b)$、$\theta^*=\theta^*(a,b)$、$m_1=m_1(a,b)$ と置く。*
> $$\theta^*-m_1<\varphi(\ell^M)\ \Longrightarrow\
> v_\ell\bigl(E(\zeta,\xi)\bigr)=\lambda+\frac{\theta^*}{\varphi(\ell^M)}.\tag{2.1}$$

**証明.** $E$ と $\tilde E$ は単項式（$\mathcal O^\times$ の元）だけ違うので $v_\ell(E(\zeta,\xi))=v_\ell(\tilde E(\zeta,\xi))$。
$\tilde E(\zeta,\xi)=R_{(a,b)}(g)$ で、$R$ から落とした単項式 $g^{\text{lo}}$ も単元だから
$v_\ell(\tilde E(\zeta,\xi))=v_\ell(\Phi_{(a,b)}(\pi))=\lambda+v_\ell(\Psi(\pi))$。
$\Psi(\pi)=\sum_mB_m\pi^m$ の各項の付値は

| $m$ | $v_\ell(B_m)$ | $v_\ell(B_m\pi^m)$ |
|---|---|---|
| $m=\theta^*$ | $=0$ | $=\theta^*\alpha$ |
| $m>\theta^*$ | $\ge0$ | $\ge m\alpha>\theta^*\alpha$ |
| $m<\theta^*$, $B_m=0$ | — | 項が無い |
| $m<\theta^*$, $B_m\neq0$ | $\ge1$ | $\ge1+m\alpha\ge1+m_1\alpha$ |

仮定 $\theta^*-m_1<\varphi(\ell^M)$ は $(\theta^*-m_1)\alpha<1$、すなわち $1+m_1\alpha>\theta^*\alpha$ と同値。
よって最小値 $\theta^*\alpha$ は $m=\theta^*$ でのみ達成され、非アルキメデス的評価から
$v_\ell(\Psi(\pi))=\theta^*\alpha$。$\blacksquare$

**注 2.4（cycle 18 定理 B の一般化）.** $\lambda=0$ なら $\theta^*=\theta$ で $(2.1)$ は cycle 18 定理 B に一致する。
定理 S はそこに $\theta=\infty$ の場合を含めた形である。

**注 2.5（$\mathbb{R}$ を使っていない）.** 使ったのは $\mathbb{Q}(\zeta_{\ell^M})$（可算な代数拡大）の
$\ell$ 上の素点での付値、$\mathbb{Z}[x]$ の内容、$\mathbb{F}_\ell[x]$ の位数だけである。
$(2.1)$ の値は $\mathbb{Q}$ の元であり、**$\mathbb{R}$ へは一度も脱出していない**。

### 2.6 定理 S の使い方に関する注意（重要）

> **$\lambda,\theta^*,m_1$ は「点 $(\zeta,\xi)$」ではなく「整数ベクトル $(a,b)$」の関数である。**

点 $(\zeta,\xi)$ は $(a,b)\bmod\ell^M$ しか決めない。$\ell=5$、$M=2$、上の例で

| 代表 $(a,b)$ | $\lambda$ | $\theta^*$ | $m_1$ | 仮定 $\theta^*-m_1<\varphi(25)=20$ | $(2.1)$ の値 $\times20$ |
|---|---|---|---|---|---|
| $(1,1)$ | $1$ | $2$ | $+\infty$ | 成立 | $22$ |
| $(1,26)$ | $0$ | $26$ | $2$ | $24<20$ は**不成立** | （使えない） |

$(1,1)$ と $(1,26)$ は $\bmod\ 25$ で同じ点を表すが $\lambda,\theta^*$ が違う。
実際の付値は $22/20$ で、$(1,1)$ の代表では $(2.1)$ が使えて正しい値を与え、
$(1,26)$ の代表では仮定が破れていて $(2.1)$ を使ってはいけない（使うと $26/20$ という誤った値になる）。
**定理 S は「ある代表で仮定が成り立てば使える」という形で運用する。**
この注意を落とすと矛盾した値を導く。

> **機械検証**: `theta_infinity.out` Step A。仮定が成り立つ全ての $(a,b)$（$|a|,|b|\le\ell^M$、$M\le2$）で
> 円分体での独立な付値計算と照合。上の表も出力してある。

---

## 3. $\theta=\infty$ の軌跡は有限本の直線

### 3.1 命題 2（判定条件）

$\chi^{(p,q)}:=z^pw^q$ と書く。

> **命題 2.** *$u=(a,b)\in\mathbb{Z}^2$ を原始ベクトル（$\gcd(a,b)=1$）とし $u^\perp:=(b,-a)$ と置く。
> $\bar\psi_u:\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]\to\mathbb{F}_\ell[y^{\pm1}]$ を $\psi_u$ の $\bmod\ \ell$ 還元とすると*
> $$\ker\bar\psi_u=\bigl(\chi^{u^\perp}-1\bigr),$$
> *したがって*
> $$\lambda(u)\ge1\iff\bigl(\chi^{u^\perp}-1\bigr)\ \bigm|\ \bar{\tilde E}\quad\text{in }\mathbb{F}_\ell[z^{\pm1},w^{\pm1}].$$

**証明.** 群準同型 $\varepsilon:\mathbb{Z}^2\to\mathbb{Z}$, $(p,q)\mapsto pa+qb$ は $u$ が原始なので全射で、
その核は $\mathbb{Z}u^\perp$ である。$\langle t,u\rangle=1$ なる $t\in\mathbb{Z}^2$ を取ると $(u^\perp,t)$ は $\mathbb{Z}^2$ の基底で、
$s:=\chi^{u^\perp}$, $v:=\chi^{t}$ と置けば $\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]=\mathbb{F}_\ell[s^{\pm1},v^{\pm1}]$、
その座標で $\bar\psi_u$ は $s\mapsto1$, $v\mapsto y$ となる。$\mathbb{F}_\ell[s^{\pm1},v^{\pm1}]/(s-1)\cong\mathbb{F}_\ell[y^{\pm1}]$
なので $\ker\bar\psi_u=(s-1)=(\chi^{u^\perp}-1)$。
後半は $\lambda(u)\ge1\iff\overline{\Phi_u}\equiv0\iff\bar\psi_u(\bar{\tilde E})=0$（補題 2.2）。$\blacksquare$

> **補題 4（スケール不変性）.** *$c\neq0$ なる任意の整数で $\lambda(ca,cb)=\lambda(a,b)$。
> さらに $\ell\nmid c$ なら $\theta^*(ca,cb)=\theta^*(a,b)$。*

**証明.** $\psi_{(ca,cb)}=(y\mapsto y^c)\circ\psi_{(a,b)}$ で、$y\mapsto y^c$ は $\mathbb{F}_\ell[y^{\pm1}]$ 上単射だから
$\bar\psi_{(ca,cb)}(\bar{\tilde E})=0\iff\bar\psi_{(a,b)}(\bar{\tilde E})=0$。内容についても同様で $\lambda$ は不変。
$\theta^*$ は cycle 18 補題 A4 と同じ議論（$\rho(x)=(1+x)^c-1$ は $\bmod\ \ell$ で位数ちょうど 1）。$\blacksquare$

**したがって $\theta=\infty$ という性質は $\mathbb{Z}^2$ の原点を通る直線に沿った性質である。**

### 3.2 命題 3（有限性・計算可能性）

> **命題 3.** *$v\in\mathbb{Z}^2$ を原始ベクトルとする。$(\chi^v-1)\mid\bar{\tilde E}$ ならば、
> 線分 $[0,v]$ は $\mathrm{Newt}(\bar{\tilde E})$ の Minkowski 因子である。とくに
> $v\in\mathrm{Newt}(\bar{\tilde E})-\mathrm{Newt}(\bar{\tilde E})\subseteq\mathrm{Newt}(\tilde E)-\mathrm{Newt}(\tilde E)$ で、
> $v$ の方向は $\mathrm{Newt}(\bar{\tilde E})$ の辺方向のいずれかに限る。*
>
> *したがって $\lambda(u)\ge1$ となる原始ベクトル $u$（$\pm$ を同一視）は**有限個**であり、
> その全体は $D$ の係数からの有限計算（$\mathbb{F}_\ell$ 上の割り算を有限個の候補について行う）で決まる。*

**証明.** Ostrowski の定理（整域上の Laurent 多項式について $\mathrm{Newt}(fg)=\mathrm{Newt}(f)+\mathrm{Newt}(g)$）を
$\bar{\tilde E}=(\chi^v-1)\cdot G$ に使う。$\mathrm{Newt}(\chi^v-1)=[0,v]$ なので
$\mathrm{Newt}(\bar{\tilde E})=[0,v]+\mathrm{Newt}(G)$。Minkowski 和の辺方向は各因子の辺方向の合併なので、
$v$ の方向は $\mathrm{Newt}(\bar{\tilde E})$ の辺方向であり、長さも対応する辺を超えない。
$[0,v]\subseteq\mathrm{Newt}(\bar{\tilde E})-p$（$p$ は適当な頂点）から差体への所属も従う。$\blacksquare$

> **定義・系 4.** $\Xi:=\{u\in\mathbb{Z}^2\setminus\{0\}:\theta(u)=\infty\}$ を**例外軌跡**、
> 命題 3 の有限個の原始ベクトル $u_1,\dots,u_r$（$\pm$ を同一視）を**例外直線**の方向と呼ぶ。
> 補題 4 と命題 3 より
> $$\Xi=\bigcup_{i=1}^{r}\bigl(\mathbb{Z}u_i\setminus\{0\}\bigr),\qquad r<\infty .$$

> **機械検証**: `theta_infinity.out` Step B・C・H5。命題 2 は箱 $|a|,|b|\le6$ の全原始ベクトルで
> 両辺を独立に計算して照合、命題 3 は「例外ならば Newton 差体に入る」を全例外について確認し、
> さらに広い箱 $|a|,|b|\le12$ で差体の外に例外が出ないことを確認した。

---

## 4. 同居構造（cycle 18 §4.5 が「$M$ 依存の具体的な姿」と呼んだもの）

### 4.1 系 5（計数）

$P\in\mathbb{P}^1(\mathbb{F}_\ell)$ を方向、レベルちょうど $M$ の点を
$\{(\zeta,\xi):\max(\mathrm{ord}\zeta,\mathrm{ord}\xi)=\ell^M\}$ とする（cycle 16 定理 D1 より方向 $P$ の
レベルちょうど $M$ の点は $(\ell-1)\ell^{2M-2}$ 個）。

> **系 5.** *$u$ を例外直線の方向、$P=u\bmod\ell\in\mathbb{P}^1(\mathbb{F}_\ell)$ とする。
> レベルちょうど $M$ の点のうち、$\mathbb{Z}u$ に属する代表を持つものは*
> $$\{cu\bmod\ell^M:\ \ell\nmid c\}\quad(\varphi(\ell^M)\ \text{個ちょうど})$$
> *であり、いずれも方向 $P$ に属する。したがって方向 $P$ のレベル $M$ の点のうち例外点の割合は*
> $$\frac{\varphi(\ell^M)}{(\ell-1)\ell^{2M-2}}=\ell^{1-M}\xrightarrow[M\to\infty]{}0 .$$
> *さらに $i\neq j$ に対し $\ell^M>|\det(u_i,u_j)|$ ならば $\mathbb{Z}u_i$ と $\mathbb{Z}u_j$ の像は
> レベル $M$ で交わらない。*

**証明.** $u$ は原始なので $u\bmod\ell\neq0$、よって $c\mapsto cu\bmod\ell^M$ は $\mathbb{Z}/\ell^M$ から単射。
$cu$ のレベルがちょうど $M$ なのは $\ell\nmid c$ のときだけで、その個数は $\varphi(\ell^M)$。
方向は補題 4 より $u\bmod\ell$ で不変。最後の主張は $cu_i\equiv c'u_j\pmod{\ell^M}$ から
$\ell^M\mid cc'\det(u_i,u_j)$（$\ell\nmid cc'$）が従うことによる。$\blacksquare$

**これが cycle 18 §4.5 の「$\theta=\infty$ の点と有限の点が同じ方向に同居する」の正確な内容である。**
同居は偶然ではなく、**方向（$\bmod\ \ell$ の情報）と整数ベクトルの直線（$\mathbb{Z}$ の情報）のずれ**である。
$M$ が上がるほど例外点は方向の中で相対的に薄くなる（割合 $\ell^{1-M}$）が、各例外点は $\lambda\ge1$ という
**方向の一般点より $1$ 以上大きい付値**を持つ。

### 4.2 系 6（$\theta=\infty$ は cycle 18 定理 C の射程外でしか起きない）

> **系 6.** *$u$ を例外直線の方向、$P=u\bmod\ell$ とすると、$(a,b)\equiv u\pmod\ell$ なる
> **すべての** $(a,b)$ で $\theta(a,b)\ge\ell+1$ である。とくに $\theta(P)\le\ell$ となることはなく、
> 例外直線を 1 本でも持つ塔は cycle 18 定理 C の仮定を必ず破る。*

**証明.** cycle 18 補題 A3（digit 安定性）より、$m\le\ell$ のとき $\bar A_m(a,b)$ は $(a,b)\bmod\ell$ だけの関数。
$u$ では $\theta(u)=\infty$ なので全ての $m$ で $\bar A_m(u)=0$、とくに $m\le\ell$ で $0$。
よって同じ $\bmod\ \ell$ 類の全ての $(a,b)$ で $\bar A_m(a,b)=0$（$m\le\ell$）、すなわち $\theta(a,b)\ge\ell+1$。$\blacksquare$

**逆は成り立たない。** cycle 18 §4.4 の例（$\ell=3$、bouquet $(1,0),(0,1),(1,1)$）は
$\theta(1{:}1)=4=\ell+1$ だが例外直線を持たない（機械検証 Step B で例外直線 0 本）。
すなわち cycle 18 の 3 つの破れ方は
$$\{\theta=\infty\}\subsetneq\{\theta\ge\ell+1\}\subsetneq\{\text{cycle 18 定理 C の射程外}\}$$
という真の包含である（右の真の包含は cycle 18 命題 F の $\ell=2,3$ による）。

### 4.3 命題 7（例外直線の $\Sigma_n$ への寄与）

> **命題 7.** *$u$ を例外直線の方向、$\lambda=\lambda(u)$、$\theta^*=\theta^*(u)$、$m_1=m_1(u)$ とし、
> $\theta^*-m_1<\ell-1$ とする（$\varphi(\ell^M)\ge\ell-1$ なので、この 1 条件で**全レベル**で定理 S が使える）。
> このときこの直線上の点の $\Sigma_n$ への寄与は*
> $$\sum_{M=1}^{n}\varphi(\ell^M)\Bigl(\lambda+\frac{\theta^*}{\varphi(\ell^M)}\Bigr)
> =\lambda\,(\ell^{n}-1)+n\,\theta^*.$$
> ***$n\ell^n$ 項は現れない。***

**証明.** 系 5 でレベルちょうど $M$ の点が $\varphi(\ell^M)$ 個、各点の付値は補題 4 と定理 S から
$\lambda+\theta^*/\varphi(\ell^M)$。$\sum_{M=1}^n\varphi(\ell^M)=\ell^n-1$。$\blacksquare$

**したがって $\theta=\infty$ の点そのものは、$\mathrm{ord}_\ell(\kappa_n)$ の $\ell^n$ 係数 $c$ と
$n$ 係数 $d$ にしか効かない。型 III の $n\ell^n$ 項は $\theta=\infty$ の点からは出てこない。**
出所は §5.3 で確定させる。

---

## 5. 完全に解けた族と、型 III の odd $\ell$ 実例

### 5.0 設定

$p,q\ge1$ を整数とし、$X$ を **1 頂点の bouquet**（voltage $(1,0)$ のループ $p$ 本、$(0,1)$ のループ $q$ 本）とする。

- 底グラフは 1 頂点なので $\kappa(X)=1$、$v_\ell(\kappa(X))=0$。
- サイクル voltage 格子は $(1,0),(0,1)$ で生成され $\mathbb{Z}^2$。よって**(H) は全ての $\ell,n$ で成立**。
- $f_z:=z+z^{-1}-2$、$f_w:=w+w^{-1}-2$ と置くと $D=\det L=-(p\,f_z+q\,f_w)$。
  係数は $-p,-q,2(p+q)$ なので $\mathrm{content}=\gcd(p,q)$、$\mu=v_\ell(\gcd(p,q))$。
  $p':=p/\ell^\mu$、$q':=q/\ell^\mu$ と置けば $E=\ell^{-\mu}D=-(p'f_z+q'f_w)$ で、
  **$p'$ と $q'$ が同時に $\ell$ で割れることはない**。
- $g(T,S)=E(1+T,1+S)$ の最低次は $H=-(p'T^2+q'S^2)$、$k=2$。

### 5.1 命題 8（この族の例外直線の完全決定）

> **命題 8.** *$\ell$ を任意の素数とする。上の族で*
> $$\theta=\infty\ \text{が起きる}\iff\ell\mid p'q'(p'+q'),$$
> *であり、3 つの場合は排反で、例外直線は次のとおり（$\theta^*=2$ はいずれの場合も共通）:*
>
> | 場合 | 例外直線の方向 | 本数 | $\lambda$ | $\Lambda:=\sum\lambda$ |
> |---|---|---|---|---|
> | $\ell\mid p'+q'$ | $(1,1)$, $(1,-1)$ | 2 | $v_\ell(p'+q')$ | $2v_\ell(p'+q')$ |
> | $\ell\mid p'$ | $(1,0)$ | 1 | $v_\ell(p')$ | $v_\ell(p')$ |
> | $\ell\mid q'$ | $(0,1)$ | 1 | $v_\ell(q')$ | $v_\ell(q')$ |
> | その他 | — | 0 | — | $0$ |

**証明.** $\tilde E=zw\,E=-\bigl(p'(z^2w+w)+q'(zw^2+z)-2(p'+q')zw\bigr)$。3 つの場合に分ける。

**(i) $\ell\nmid p'q'$.** $\bar{\tilde E}$ の $4$ つの単項式 $z^2w,\ w,\ zw^2,\ z$ の係数は $-p',-p',-q',-q'$ で
すべて $\neq0$。よって $\mathrm{Newt}(\bar{\tilde E})$ は頂点 $(2,1),(1,2),(0,1),(1,0)$ の平行四辺形で、
辺方向は $\pm(1,1),\pm(1,-1)$、各辺の長さは原始ベクトル 1 個分。命題 3 より候補は
$v=\pm(1,1),\pm(1,-1)$ だけ、すなわち $u\in\{(1,-1),(1,1)\}$（$\pm$ 同一視）に限る。
判定は $\psi_u(\tilde E)$ の $\bmod\ \ell$ 還元を見ればよい:
$$\psi_{(1,1)}(\tilde E)=y^2\cdot\bigl(-(p'+q')(y+y^{-1}-2)\bigr)=-(p'+q')\,y\,(y-1)^2,$$
$$\psi_{(1,-1)}(\tilde E)=-(p'+q')(y+y^{-1}-2)\cdot y^{0}\cdot(\text{単項式})=-(p'+q')\,y^{-1}(y-1)^2\cdot(\text{単項式}).$$
（$f$ は $z\mapsto z^{-1}$ で不変なので $\psi_{(1,-1)}$ でも $p'f+q'f$ の形になる。）
どちらも $\bmod\ \ell$ で消えるのは $\ell\mid p'+q'$ のときだけ。
そのとき $\Phi_u(x)=-(p'+q')x^2\cdot(\text{単元})$ なので $\lambda=v_\ell(p'+q')$、$\theta^*=2$、$m_1=+\infty$。

**(ii) $\ell\mid p'$（このとき $\ell\nmid q'$）.** $\bar{\tilde E}=-q'(zw^2+z)+2q'zw=-q'z(w-1)^2$。
$\mathrm{Newt}$ は線分 $[(1,0),(1,2)]$、辺方向は $\pm(0,1)$ のみ。候補は $v=(0,1)$、すなわち $u=(1,0)$。
$\psi_{(1,0)}(\tilde E)=\tilde E(y,1)=-p'\,y\,(y+y^{-1}-2)=-p'(y-1)^2$ なので
$\lambda=v_\ell(p')\ge1$、$\theta^*=2$、$m_1=+\infty$。他の方向は $\mathrm{Newt}$ の辺方向でないので命題 3 により除外。

**(iii) $\ell\mid q'$.** (ii) と $z\leftrightarrow w$ の対称。$\blacksquare$

**注 5.1.** $\ell=2$ でも命題 8 は成り立つ（場合 (i) では例外直線が 2 本のまま。$\bmod\ 2$ で
$(1,1)$ と $(1,-1)$ は同じ方向に落ちるが、**整数ベクトルの直線としては別物**である）。

> **機械検証**: `theta_infinity.out` Step G2。$1\le p,q\le12$、$\ell\in\{2,3,5,7,11,13\}$ の
> **全 $144\times6$ 組**で、例外直線の本数・方向・$\lambda$ を独立計算と照合した。

### 5.2 定理 X（この族の点ごとの付値）

以下 **$\ell$ は奇素数**とする（$\ell=2$ については §9.3）。
$n\ge1$、$g$ を原始 $\ell^n$ 乗根、$(a,b)\in(\mathbb{Z}/\ell^n)^2\setminus\{0\}$、
$\nu(x):=v_\ell(x)$（$x\equiv0$ なら $\nu=n$）、$\varphi_m:=\varphi(\ell^m)$ と書く。

> **定理 X.** *命題 8 の場合分けに従って、$v_\ell\bigl(E(g^a,g^b)\bigr)$ は次で完全に決まる。*
>
> **[A] $\ell\mid p'+q'$（$\lambda_0:=v_\ell(p'+q')$）.** $\varepsilon:=\min(\nu(a),\nu(b))$、$m:=n-\varepsilon$、
> $a':=a/\ell^\varepsilon$, $b':=b/\ell^\varepsilon\in\mathbb{Z}/\ell^m$ と置くと
> $$\varphi_m\,v_\ell(E)=\begin{cases}
> 2 & a',b'\ \text{の一方だけが単元}\\[2pt]
> \lambda_0\varphi_m+2 & \text{両方単元かつ}\ a'\equiv\pm b'\ (\mathrm{mod}\ \ell^m)\quad(\theta=\infty\ \text{の点})\\[2pt]
> 1+\ell^{\,r} & \text{両方単元、}\ r:=\max\bigl(\nu(a'-b'),\nu(a'+b')\bigr)<m
> \end{cases}$$
>
> **[B] $\ell\mid p'$（$\lambda_1:=v_\ell(p')$）.**
> $$\varphi_n\,v_\ell(E)=\begin{cases}
> 2\,\ell^{\nu(b)} & \nu(b)<n\\[2pt]
> \lambda_1\varphi_n+2\,\ell^{\nu(a)} & b\equiv0\ (\text{このとき}\ a\not\equiv0)
> \end{cases}$$
> **[B′] $\ell\mid q'$** は [B] で $a\leftrightarrow b$ を入れ替えたもの。

**証明.**

**[A].** $h:=g^{\ell^\varepsilon}$ は原始 $\ell^m$ 乗根で、$f(c):=h^c+h^{-c}-2$ と置くと
$E(g^a,g^b)=-\bigl(p'f(a')+q'f(b')\bigr)$（$\min(\nu(a'),\nu(b'))=0$）。

*一方だけ単元のとき*: $\ell\nmid a'$, $\ell\mid b'$ とする。$h^{a'}$ は原始 $\ell^m$ 乗根なので
$v_\ell(f(a'))=2v_\ell(h^{a'}-1)=2/\varphi_m$。一方 $v_\ell(f(b'))=2\ell^{\nu(b')}/\varphi_m>2/\varphi_m$
（$b'\equiv0$ なら $f(b')=0$）。$\ell\nmid p'q'$（場合 [A] の仮定）なので $v_\ell(E)=2/\varphi_m$。

*両方単元のとき*: 恒等式
$$p'f(a')+q'f(b')=p'\bigl(f(a')-f(b')\bigr)+(p'+q')f(b')$$
を使う。第 1 項について
$$f(a')-f(b')=\bigl(h^{a'}-h^{b'}\bigr)\bigl(1-h^{-(a'+b')}\bigr)=-h^{-a'}\bigl(h^{a'-b'}-1\bigr)\bigl(h^{a'+b'}-1\bigr)$$
（展開して両辺 $h^{a'}+h^{-a'}-h^{b'}-h^{-b'}$ を確認できる）。よって
$$v_\ell\bigl(f(a')-f(b')\bigr)=v_\ell\bigl(h^{a'-b'}-1\bigr)+v_\ell\bigl(h^{a'+b'}-1\bigr)
=\frac{\ell^{\nu(a'-b')}+\ell^{\nu(a'+b')}}{\varphi_m}$$
（$h^N-1$ は $N\not\equiv0$ のとき原始 $\ell^{m-\nu(N)}$ 乗根 $-1$ なので付値 $1/\varphi(\ell^{m-\nu(N)})=\ell^{\nu(N)}/\varphi_m$、
$N\equiv0$ なら $0$ で付値 $\infty$）。
$\ell$ は奇で $\ell\nmid a'$ だから $(a'-b')+(a'+b')=2a'$ は単元、よって
$\nu(a'-b')$ と $\nu(a'+b')$ が同時に正になることはない。すなわち一方は $0$、他方が $r$ である。
第 2 項は $b'$ が単元なので $v_\ell\bigl((p'+q')f(b')\bigr)=\lambda_0+2/\varphi_m$。

- $r<m$（$a'\not\equiv\pm b'$）のとき、$\varphi_m$ 倍して比べると第 1 項は $1+\ell^r$、第 2 項は $\lambda_0\varphi_m+2$ で、
 $\lambda_0\ge1,\ \ell\ge3$ より
 $$\lambda_0\varphi_m+2\ \ge\ \ell^{m-1}(\ell-1)+2\ \ge\ 2\ell^{m-1}+2\ >\ \ell^{m-1}+1\ \ge\ \ell^{r}+1 .$$
 **狭義の不等号**なので $v_\ell(E)=(1+\ell^r)/\varphi_m$（$\ell\nmid p'$ に注意）。
- $a'\equiv\pm b'\pmod{\ell^m}$ のとき、$f(a')-f(b')=0$（$f$ は偶関数）なので
 $E=-(p'+q')f(b')$、$v_\ell(E)=\lambda_0+2/\varphi_m$。

**[B].** $h=g$、$m=n$ として $-E=p'f(a)+q'f(b)$。
$v_\ell\bigl(p'f(a)\bigr)=\lambda_1+2\ell^{\nu(a)}/\varphi_n$（$a\equiv0$ なら $\infty$）、
$v_\ell\bigl(q'f(b)\bigr)=2\ell^{\nu(b)}/\varphi_n$（$b\equiv0$ なら $\infty$）。
$b\not\equiv0$ のとき $\varphi_n$ 倍して比べると
$$\lambda_1\varphi_n+2\ell^{\nu(a)}\ \ge\ \ell^{n-1}(\ell-1)+2\ \ge\ 2\ell^{n-1}+2\ >\ 2\ell^{n-1}\ \ge\ 2\ell^{\nu(b)}$$
で**狭義**、よって $v_\ell(E)=2\ell^{\nu(b)}/\varphi_n$。$b\equiv0$ なら $f(b)=0$ で第 2 項が消える。$\blacksquare$

**注 5.2（どこで $\ell$ が奇であることを使ったか）.** 3 箇所である。
(i) $2$ が単元（$\nu(a'-b')$ と $\nu(a'+b')$ が同時に正にならない）、
(ii) $a'\equiv b'$ と $a'\equiv-b'$ が排反、
(iii) $\ell-1\ge2$（上の狭義不等号）。$\ell=2$ ではいずれも壊れる（§9.3）。

**注 5.3（$\theta=\infty$ の点の値の読み）.** [A] の第 2 行 $\lambda_0+2/\varphi_m$ は定理 S の
$(2.1)$ に $\lambda=\lambda_0$, $\theta^*=2$ を入れたものであり、命題 8 と整合している。
[B] の $b\equiv0$ 行も同様。

> **機械検証**: `theta_infinity.out` Step F1。$\ell\in\{3,5,7,11\}$、$(p,q)$ 21 組について
> レベル $\le n_{\max}$（$\ell=3$: 3、$\ell=5,7$: 2、$\ell=11$: 1）の**全点**で
> 円分体での独立な付値計算と照合（標本抽出ではない）。

### 5.3 定理 X′（この族の閉形式）

> **定理 X′（本サイクルの主結果）.** *$\ell$ を奇素数とし、上の族で例外直線が存在する
> （$\ell\mid p'q'(p'+q')$）とする。$\Lambda$ を命題 8 の表の値とすると、**全ての $n\ge0$** で*
> $$\boxed{\ \mathrm{ord}_\ell(\kappa_n)=\mu\,(\ell^{2n}-1)+2\,n\,\ell^{n}+\Lambda\,(\ell^{n}-1).\ }\tag{5.1}$$
> *cycle 14 $(7.2)$ の 5 係数は $a=\mu$, $b=2$, $c=\Lambda$, $d=0$, $e=-\mu-\Lambda$、$n_0=0$。*

**証明.** $(1.1)$ と $v_\ell(\kappa(X))=0$ より $\Sigma_n=2n\ell^n+\Lambda(\ell^n-1)+2n$ を示せばよい。

**場合 [A]（$\Lambda=2\lambda_0$）.** レベルちょうど $m$ の点の寄与 $S_m$ を数える
（定理 X [A] の記法で $\varepsilon=0$、$a',b'\in\mathbb{Z}/\ell^m$、$\min(\nu(a'),\nu(b'))=0$）。
$U:=(\mathbb{Z}/\ell^m)^\times$、$|U|=\varphi_m$ とする。

- 片方だけ単元: 個数 $2\varphi_m\ell^{m-1}$、各 $\varphi_mv=2$。小計 $4\varphi_m\ell^{m-1}$。
- 両方単元（$\varphi_m^2$ 組）:
  - $a'\equiv\pm b'$: $2\varphi_m$ 組（$\ell$ 奇なので排反）、各 $\varphi_mv=\lambda_0\varphi_m+2$。
  - $r=j$（$1\le j\le m-1$）: $\nu(a'-b')=j$ または $\nu(a'+b')=j$ で、各々 $\varphi_m\cdot\varphi(\ell^{m-j})$ 組、
    合わせて $2\varphi_m\ell^{m-j-1}(\ell-1)$ 組、各 $\varphi_mv=1+\ell^j$。
  - $r=0$: 残り $\varphi_m^2-2\varphi_m-2\varphi_m(\ell^{m-1}-1)=\varphi_m\ell^{m-1}(\ell-3)$ 組、各 $\varphi_mv=2$。

（$\sum_{j=1}^{m-1}\ell^{m-j-1}(\ell-1)=\ell^{m-1}-1$ を使った。）足し合わせると

$$\varphi_mS_m=4\varphi_m\ell^{m-1}+2\varphi_m(\lambda_0\varphi_m+2)
+2\varphi_m\bigl[(\ell^{m-1}-1)+(m-1)(\ell-1)\ell^{m-1}\bigr]+2\varphi_m\ell^{m-1}(\ell-3),$$

$$S_m=2+2\ell^{m-1}\bigl[(\lambda_0+m-1)(\ell-1)+\ell\bigr].$$

$\sum_{m=1}^n\ell^{m-1}=\dfrac{\ell^n-1}{\ell-1}$、$\sum_{m=1}^n(m-1)\ell^{m-1}=\dfrac{(n-1)\ell^{n+1}-n\ell^n+\ell}{(\ell-1)^2}$
を代入して整理すると

$$\Sigma_n=\sum_{m=1}^nS_m=2n+2\lambda_0(\ell^n-1)+\frac{2\bigl[(n-1)\ell^{n+1}-n\ell^n+\ell\bigr]+2\ell(\ell^n-1)}{\ell-1}
=2n\ell^n+2\lambda_0(\ell^n-1)+2n .$$

（最後の分数は分子が $n\ell^{n+1}-n\ell^n=n\ell^n(\ell-1)$ になるので $2n\ell^n$。）

**場合 [B]（$\Lambda=\lambda_1$）.** レベルで層別せず直接 $(a,b)\in(\mathbb{Z}/\ell^n)^2\setminus\{0\}$ で数える。
$\nu(x)=\alpha<n$ なる $x$ は $\varphi(\ell^{n-\alpha})=\ell^{n-\alpha-1}(\ell-1)$ 個。

$$\varphi_n\Sigma_n=\underbrace{\sum_{\beta=0}^{n-1}\ell^{n}\,\ell^{n-\beta-1}(\ell-1)\cdot2\ell^{\beta}}_{b\not\equiv0\ (a\ \text{は任意})}
+\underbrace{\sum_{\alpha=0}^{n-1}\ell^{n-\alpha-1}(\ell-1)\bigl(\lambda_1\varphi_n+2\ell^{\alpha}\bigr)}_{b\equiv0}$$
$$=2\ell^{n}(\ell-1)n\ell^{n-1}+\lambda_1\varphi_n(\ell^n-1)+2(\ell-1)n\ell^{n-1}
=\varphi_n\bigl[2n\ell^n+\lambda_1(\ell^n-1)+2n\bigr].$$

**場合 [B′]** は対称。いずれも $\Sigma_n=2n\ell^n+\Lambda(\ell^n-1)+2n$ で、$(1.1)$ に入れて
$\mathrm{ord}_\ell(\kappa_n)=0-2n+\mu(\ell^{2n}-1)+\Sigma_n=(5.1)$。$n=0$ では両辺 $0$。$\blacksquare$

**注 5.4（$n\ell^n$ 項の出所を分解する）.** 場合 [A] の内訳から、$\Sigma_n$ の 3 つの部分は

| 部分 | $\Sigma_n$ への寄与 |
|---|---|
| $\theta=\infty$ の点（例外直線） | $2\bigl[\lambda_0(\ell^n-1)+2n\bigr]$（命題 7 と一致） |
| $r\ge1$ の点（有限だが深い。$\theta=1+\ell^r$） | $n\ell^n$ 項を含む主要部 |
| $r=0$ と片側の点（浅い） | $\ell^n$ のオーダー |

**すなわち型 III の $n\ell^n$ 項は、$\theta=\infty$ の点そのものではなく、
その $\ell$ 進近傍で $\theta$ が $1+\ell^r$ と幾何級数的に深くなる点の集積から出る。**
例外直線は、その集積の「中心」である。

> **機械検証**: `theta_infinity.out` Step F2・F3・F4・H4。
> F2 は $\Sigma_n$ を全点の和として独立に計算して閉形式と照合、
> F3 は塔の値 $\kappa_n$ を 2 段終結式で独立に厳密計算して $(5.1)$ と照合
> （**フィットパラメータ 0 個**。予言に使うのは $\mu$ と $\Lambda$ だけ）、
> H4 は上の 3 分解を数値で出している。

### 5.4 系 X″（型 III は「小さい $\ell$ の現象」ではない）

> **系 X″.** *任意の奇素数 $\ell$ について、$(5.1)$ の族は $b=2\neq0$、すなわち**型 III**の塔を与える。
> 例えば $\ell\mid p+q$ かつ $\ell\nmid p$ を満たす任意の $(p,q)$（$\ell$ ごとに無限個ある）でよい。*

cycle 16 §7 の分類（型 I: 非退化、型 II: 退化かつ $n\ell^n$ 項なし、型 III: $n\ell^n$ 項あり）で、
これまでに得られていた型 III の実例は **$\ell=2$ のトーラス 1 件だけ**であった。
cycle 18 §5.1 は母集団 2081 個の全走査で「$\ell\ge5$ の退化塔は**すべて**型 II と判定できた」と述べ、
「型 III（$n\ell^n$ 項が出る）は**小さい $\ell$ の現象**である」と読んでいる。

**この読みは母集団の人工物である。** cycle 18 の母集団は bouquet 2–3 ループと 2 頂点 3–4 重辺に
限られており、$\ell\ge5$ で例外直線を作るには**係数の和が $\ell$ に届く必要がある**（命題 8）。
辺数が 5 以下では $\ell=7,11$ でそれが起きない。本 report の族はこの制限を外しただけで、
**すべての奇素数 $\ell$ で型 III が現れる**（例: $\ell=7$ の $(p,q)=(3,4)$ で
$\mathrm{ord}_7(\kappa_n)=2n7^n+2(7^n-1)$、$\ell=11$ の $(5,6)$ で $2n11^n+2(11^n-1)$）。

> **訂正（cycle 20 step 4 が Lean 化の過程で検出、2026-08-01）.** 上の 2 例は当初
> $\Lambda=1$ として $2n7^n+7^n-1$・$2n11^n+11^n-1$ と書いていたが**誤りだった**。
> $(3,4)$ は $7\mid3+4$、$(5,6)$ は $11\mid5+6$ なので、どちらも命題 8 の場合 [A]
> （例外直線 2 本）であり $\Lambda=2v_\ell(p'+q')=2$ である。$n=1$ の真値は
> $\mathrm{ord}_7(\kappa_1)=26$、$\mathrm{ord}_{11}(\kappa_1)=42$ で、訂正版の式と一致する
> （呼び出し元がラプラシアン余因子から独立に計算して確認）。
> **誤っていたのはこの例示 2 行だけで、定理 X′ 本体・命題 8 の表・機械検証はいずれも正しい**
> （$\Lambda$ の定義に従えばこの 2 例は場合 [A] に入る、と本文は正しく述べている）。
> 詳細は `cycle20_ops_lean_cycle19_theorems.md` §1.4。

**cycle 18 は自分でこの罠（0 件の観察を根拠にしない）を明示していたが、
「全件型 II」という肯定側の観察でも同じ罠が働くことは書いていない。**

### 5.5 命題 9（この族は $\ell$ 奇なら完全に解けている）

> **命題 9.** *$\ell$ を奇素数とすると、族 $p(1,0)+q(0,1)$ の塔は次の 3 つのいずれかちょうど 1 つに入り、
> いずれの場合も $\mathrm{ord}_\ell(\kappa_n)$ の閉形式が既に得られている。*
> 1. *非退化（$z_H=0$）: cycle 16 定理 N1 / cycle 18 系 D。*
> 2. *退化かつ例外直線なし: $\theta(P)=4$（全退化方向）で $\ell\ge5$、cycle 18 定理 C（型 II）。
>    $\ell=3$ ではこの場合は空である。*
> 3. *例外直線あり: 本サイクルの定理 X′（型 III）。*

**証明.** 3 は命題 8 の条件そのもの。以下 $\ell\nmid p'q'(p'+q')$ とする。
$H=-(p'T^2+q'S^2)$ の $\mathbb{P}^1(\mathbb{F}_\ell)$ 零点は $T^2/S^2=-q'/p'$ の解なので、
$z_H\ne0\iff-q'/p'$ が $\mathbb{F}_\ell^\times$ の平方。これが 1 の場合。

2 の場合、退化方向 $(a,b)$（$\ell\nmid ab$、$p'a^2+q'b^2\equiv0$）での $\theta$ を計算する。
$F_c(x):=(1+x)^c+(1+x)^{-c}-2=\sum_m\bigl[\binom cm+\binom{-c}m\bigr]x^m$ の低次係数は
$$m=0,1:\ 0,\qquad m=2:\ c^2,\qquad m=3:\ -c^2,\qquad m=4:\ \frac{c^4+11c^2}{12}$$
（いずれも整数。$m=4$ は $\binom c4+\binom{-c}4=\frac{c[(c-1)(c-2)(c-3)+(c+1)(c+2)(c+3)]}{24}$ から）。
$-E$ の制限は $p'F_a+q'F_b$（単元倍を除く）なので、
$\bar A_2=p'a^2+q'b^2=0$、$\bar A_3=-(p'a^2+q'b^2)=0$、
$$\bar A_4=\frac{p'a^4+q'b^4}{12}+\frac{11(p'a^2+q'b^2)}{12}=\frac{p'a^4+q'b^4}{12}\quad(\ell\ge5\ \text{で}\ 12\ \text{は単元}).$$
$q'b^2=-p'a^2$ より $q'b^4=(q'b^2)^2/q'=p'^2a^4/q'$、よって
$p'a^4+q'b^4=\dfrac{p'a^4(p'+q')}{q'}\neq0$（$\ell\nmid p'q'(p'+q')a$）。
すなわち $\theta(P)=4$。非退化方向は $\theta=2$。全方向で $\theta\le4\le\ell$（$\ell\ge5$）なので
cycle 18 定理 C が使える。

$\ell=3$ のときは、平方剰余が $\{1\}$ だけなので $z_H\neq0\iff-q'/p'\equiv1\iff\ell\mid p'+q'$、
すなわち退化なら必ず 3 の場合に入る。よって 2 は空。$\blacksquare$

**注 5.5.** cycle 18 命題 F は「$\ell=2,3$ の退化塔は例外なく定理 C の射程外」と述べていた。
命題 9 は、$\ell=3$ についてはその射程外の塔（この族に限る）が**定理 X′ で完全に解ける**ことを示している
（例: $\ell=3$, $(p,q)=(2,1)$ で $\mathrm{ord}_3(\kappa_n)=2n3^n+2\cdot3^n-2$）。

> **機械検証**: `theta_infinity.out` Step F5。$1\le p,q\le10$、$\ell\in\{3,5,7,11,13\}$ の
> **全 100 組 × 5 素数**で 3 分割が成り立つこと、および 2 の場合に $\theta$ プロファイルが
> $\{2,4\}$ に収まることを確認。

---

## 6. $\theta=\infty$ になる方向の判定と分類

### 6.1 判定手続き（一般の塔）

命題 2 ＋ 命題 3 より、次は**有限手続き**である（$D$ の係数だけを使い、塔の値も円分体も使わない）。

1. $\tilde E$ を作り $\bar{\tilde E}\in\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]$ を取る。
2. $\mathrm{Newt}(\bar{\tilde E})$ の辺方向（原始ベクトル）を列挙する。候補は有限個。
3. 各候補 $v$ について $(\chi^v-1)\mid\bar{\tilde E}$ を割り算で判定する。
4. 割れたものが例外直線 $u=(-v_2,v_1)$。各々について $\lambda(u)$、$\theta^*(u)$ を
   $\Phi_u\in\mathbb{Z}[x]$ の内容と位数として読む。

**判定は $\Lambda/\overline{\mathbb{Q}}$ の側に留まり $\mathbb{R}$ を使わない。**

### 6.2 母集団を網羅した分類

宣言する母集団（**全走査**であり標本抽出ではない。この母集団については完全な判定であって、
母集団の外については何も言わない）:

- (a) 1 頂点 bouquet、ループ本数 $L=2,\dots,5$、voltage は $\{(1,0),(0,1),(1,1),(1,-1),(2,1),(1,2)\}$ からの重複あり組合せ
- (b) 2 頂点平行多重辺、本数 $3,\dots,5$、voltage は $\{(0,0),(1,0),(0,1),(1,1)\}$ からの重複あり組合せ

合計 **566 個**の voltage グラフ。(H) を満たすものだけを対象にした結果:

| $\ell$ | (H) を満たす塔 | 退化塔 | cycle 18 定理 C 適用可 | $\theta=\infty$ を持つ塔 | 例外直線の本数分布 |
|---|---|---|---|---|---|
| 2 | 446 | 446 | 0 | **392** | 1 本:213 / 2 本:124 / 3 本:55 |
| 3 | 436 | 291 | 145 | **205** | 1 本:126 / 2 本:79 |
| 5 | 476 | 317 | 314 | **144** | 1 本:84 / 2 本:60 |
| 7 | 476 | 274 | 476 | **0** | — |
| 11 | 476 | 226 | 476 | **0** | — |

読み方（**この読み違えが cycle 18 で起きたので明示する**）:

- $\ell=2$ で「定理 C 適用可 0」は cycle 18 命題 F の帰結であって探索範囲の狭さではない。
- **$\ell=7,11$ の「0 件」は母集団の人工物である。** この母集団の辺数は 5 以下で、
  命題 8 のような「係数和が $\ell$ で割れる」状況が作れない。族を広げれば
  **任意の素数で $\theta=\infty$ は起きる**（Step G2: $1\le p,q\le12$ で $\ell=13$ でも 12/144 組）。
- したがって「$\theta=\infty$（および型 III）は小さい $\ell$ の現象」という読みは**誤り**である（§5.4）。

族 $p(1,0)+q(0,1)$ については命題 8 が完全な判定を与えるので、その全走査結果:

| $\ell$ | 2 | 3 | 5 | 7 | 11 | 13 |
|---|---|---|---|---|---|---|
| $1\le p,q\le12$ のうち $\theta=\infty$ を持つ組 | 144/144 | 106/144 | 64/144 | 42/144 | 34/144 | 12/144 |

（$\ell=2$ が全件なのは $p'q'(p'+q')$ が必ず偶数であることによる。）

---

## 7. 証明したことと、数値支持どまりのことの区別

**本 report に「数値だけで支持している主張」は 1 件も無い。**

- §2–§5 の定理 S、命題 2・3・7・8・9、補題 4、系 5・6、定理 X・X′、系 X″ には
  **有限個の例に依らない証明**を本文に書いた。
- §6.2 の件数は、**宣言した有限母集団の全走査**の結果である。標本抽出ではないので
  「破れ率何 % まで検出できるか」という検出力の議論は当てはまらない。
  代わりに**母集団の境界**（辺数・voltage・素数の範囲）を明示し、
  外側について何も主張しないことを明記した。
- §9.1 の否定的結論（定理 X′ の素朴な一般化は成り立たない）は**反例による否定**であり、
  反例は独立計算（2 段終結式による $\kappa_n$ の厳密計算）で確認してある。

機械検証の**到達範囲**（証明そのものではなく、証明の照合が届いた範囲）:

| Step | 照合の範囲 |
|---|---|
| A（定理 S） | 9 塔 × $M\le2$ × $|a|,|b|\le\ell^M$ の全点のうち仮定成立分 |
| B・C（命題 2・3、補題 4） | 9 塔 × 原始ベクトル $|a|,|b|\le6$（H5 で $\le12$） |
| F1（定理 X） | 21 組 × レベル $\le n_{\max}$ の**全点** |
| F3（定理 X′） | 21 組 × $n\le n_{\max}$（$\ell=3$: 3、$\ell=5,7$: 2、$\ell=11$: 1） |
| F5（命題 9） | $1\le p,q\le10$ × $\ell\in\{3,5,7,11,13\}$ の全組 |
| G（分類） | 566 塔 × $\ell\in\{2,3,5,7,11\}$ の全組 |
| G2（命題 8） | $1\le p,q\le12$ × $\ell\in\{2,3,5,7,11,13\}$ の全組 |

**「全ての $n$ で数値確認した」とは書かない。** 定理 X′ の $n$ は証明では任意だが、
照合が届いた $n$ には上限がある（上表）。総 FAIL 0・打ち切り 0 件は `RESULTS.md` に記す。

---

## 8. 本サイクルで自分が犯した誤り（隠さず記録する）

### 8.1 命題 8 を狭く立てて偽の主張を書いた

最初に立てた命題 8 は

> $\theta=\infty$ が起きる $\iff\ell\mid p+q$、例外直線はちょうど 2 本

だった。これは **$\ell\mid p'$ や $\ell\mid q'$ の場合を落としていて偽**である。
反例: $\ell=2$, $(p,q)=(1,2)$。$2\nmid p+q=3$ だが $\bar E=-f_z$ が $(w-1)$ ではなく
$(z-1)^2$ を因子に持ち、例外直線 $\mathbb{Z}(0,1)$ が存在する。

**検出したのは Step G2 の全組合せ照合**（$144\times6$ 組）で、**436 件の FAIL** が出た。
特定の例だけを見ていたら見逃していた。

**根本原因**: 命題 3 の候補を $\mathrm{Newt}(\tilde E)$（$\mathbb{Z}$ 上）から取っていた。
正しくは $\mathrm{Newt}(\bar{\tilde E})$（$\mathbb{F}_\ell$ 上）で、$\ell\mid p'$ のとき
mod $\ell$ の Newton 多角形は**正方形から線分へ潰れ、新しい辺方向が現れる**。
$\mathbb{Z}$ 上の多角形は上界としては正しい（$\mathrm{Newt}(\bar F)\subseteq\mathrm{Newt}(F)$）が、
「候補は $\pm(1,1),\pm(1,-1)$ の 2 本だけ」という**絞り込みには使えない**。
本文の命題 3 と §5.1 の証明はこの点を修正してある。

### 8.2 主結果を狭い形で書きかけた

8.1 の誤りのため、定理 X′ を最初は「$\ell\mid p+q$ の場合の $2(n+\lambda_0)\ell^n-2\lambda_0$」という
形だけで書こうとしていた。$\ell\mid p'$ の場合を入れて統一した結果、
$\Lambda=\sum_{\text{例外直線}}\lambda$ という**例外直線の言葉での統一形** $(5.1)$ が得られた。
誤りを潰す過程で主結果が一般化した形になっている。

### 8.3 検証設計上の反省

cycle 18 §8 の 6′ と同じ教訓が再現した:
**「特定の例で合う」ことを確かめる検証では、主張の欠落は見つからない。**
今回見つかったのは、全組合せに対して**同値**（$\iff$）を照合する形で書いたためである。
片側（$\Rightarrow$）だけを照合していたら 8.1 の誤りは残っていた。

---

## 9. 取れなかったこと・射程外

### 9.1 定理 X′ の形は一般の塔へは延長できない（反例で確定）

定理 X′ はこの族では $k=2$ なので $(5.1)$ を「$\mu(\ell^{2n}-1)+k\,n\ell^n+\Lambda(\ell^n-1)+v_\ell(\kappa_X)$」と
読むことができる。この読みを**例外直線を持つ一般の塔**へ素朴に延長すると**偽**である。

**反例**（$\ell=3$、bouquet voltage $(1,0),(1,-1),(1,2)$、$\mu=0$、$k=2$、$z_H=1$、
例外直線 1 本 $\mathbb{Z}(1,0)$、$\lambda=1$、$\theta^*=2$、$v_\ell(\kappa_X)=0$）:

| $n$ | 0 | 1 | 2 |
|---|---|---|---|
| 実測 $\mathrm{ord}_3(\kappa_n)$ | 0 | 10 | 50 |
| 素朴な延長 $2n3^n+(3^n-1)$ | 0 | 8 | 44 |

**$\ell=5$ の反例**（bouquet voltage $3\times(1,0),(0,1),(1,2)$、$\mu=0$、$k=2$、$\Lambda=1$）:
実測 $0,16,120$ に対し素朴な延長は $0,14,124$。

Step H6 は §6.2 の母集団のうち例外直線を持つ塔**すべて**でこの検算を行っており、
一致しない塔の件数は $\ell=2$ で 305/392、$\ell=3$ で 45/205、$\ell=5$ で 60/144 である。
**すなわち素朴な延長は「たまに外れる」のではなく、系統的に成り立たない。**

**何が足りないか**（次に試すべき具体的な手順として書く）: 定理 X′ の証明で効いたのは
「例外直線の近傍で $\theta$ が $1+\ell^r$ という**具体的な形**で深くなること」であり、
これは $\bar E$ が 2 項式の積に**分解する**（$\bar E=c\chi^{w}\prod_i(\chi^{v_i}-1)^{e_i}$）ことから来ている。
分解する場合には一般に
$$\theta(a,b)=\sum_ie_i\,\ell^{\,v_\ell(\langle v_i,(a,b)\rangle)}\qquad(\text{全ての}\ \langle v_i,(a,b)\rangle\neq0)$$
となる（$\psi_{(a,b)}(\chi^{v_i}-1)=y^{N_i}-1$ の位数が $\ell^{v_\ell(N_i)}$ であることによる）はずで、
これを土台に $\Sigma_n$ を閉じるのが自然な次の一手である。
**本 step ではこの一般形を証明していない**（族の場合を直接計算した）。
分解しない場合（既約成分が 2 項式でない場合）は手がかりが無い。

### 9.2 $\theta\ge\ell+1$ かつ例外直線なしの塔

系 6 の真の包含のとおり、$\{\theta\ge\ell+1\}$ は $\{\theta=\infty\}$ より真に広く、
その差分（cycle 18 §4.4 の $\ell=3$ の例など）は本 step の方法では扱えない。
これは **cycle 19 step 1（`degenerate_tower_theta_ge_ell_plus_1`）の担当**である。

### 9.3 $\ell=2$

定理 X・X′ の証明は注 5.2 の 3 箇所で $\ell$ が奇であることを使っており、$\ell=2$ では成り立たない。
実測（Step H2）: $\ell=2$ のトーラス（$p=q=1$）は
$\mathrm{ord}_2(\kappa_n)=0,5,19,61,167$（$n=0..4$）で、$(5.1)$ を当てた $0,6,22,62,158$ とは一致せず、
cycle 16 定理 D2 の既知の閉形式 $2n2^n+4\cdot2^n-6n-1$ と一致する。
**$\ell=2$ は $\Sigma_n$ の $-6n$ という線形項を持つ点で構造的に違う。**
なお $\ell=2$ の母集団では 446 塔中 392 塔が例外直線を持つ（§6.2）ので、
$\ell=2$ は「$\theta=\infty$ が例外ではなく常態」の世界である。

### 9.4 段数の壁

cycle 16 §8-2 と同じく、$\mathrm{ord}_\ell(\kappa_n)$ の独立計算は次数 $\ell^{2n}$ の 2 段終結式なので
到達段数に上限がある。本 report の結論はこの壁を**回避**した（点ごとの付値を証明したので
塔の値を計算する必要が無い）のであって、壁自体は残っている。

### 9.5 その他

- $d\ge3$ は対象外（$(1.1)$ 自体が $d=2$ の式）。
- 族 $p(1,0)+q(0,1)$ 以外の**一般の**塔について、例外直線があるときの閉形式は得ていない
  （命題 7 で例外直線そのものの寄与は決まっているが、近傍の寄与が決まらない。§9.1）。

---

## 10. 既知性・新規性

**新規性は主張しない。**

- 「Laurent 多項式が $\chi^v-1$ で割れる」という条件と、Newton 多面体の Minkowski 分解による
  その候補の有限化（命題 2・3）は、いずれも標準的な道具である。
  $\bar E$ の 2 項式因子は、群環 $\mathbb{F}_\ell[\mathbb{Z}^2]$ の言葉では
  「部分群 $\mathbb{Z}u^\perp$ の増大イデアルで割れる」ことにあたり、
  岩澤加群の擬同型分解や Monsky / Cuoco–Monsky の枠組みで対応する概念が既に導入されている
  可能性は高い。**確認できていない**（両論文の本文照合は本 step の作業に含めていない。
  cycle 18 step 4 で入手した Monsky, ASPM 17 (1989) にはこの形の記述は見当たらなかったが、
  本 step では改めて読んでいない）。
- 定理 X′ の $(5.1)$ は、グラフの $\mathbb{Z}_\ell^2$ 塔について $n\ell^n$ 項が
  odd $\ell$ で現れる具体例を与える。$n p^n$ 型の項自体は Cuoco–Monsky 型の漸近公式で
  よく知られた形であり、**新規なのは「係数が有限計算で決まる具体族」を出した点だけ**である。
- **文献は abstract だけで「確認した」と書かない**という原則に従い、
  **本 step で新たに本文を確認した文献は無い**。

---

## 11. 敵対的レビュー（自分の結論を反証しにいった記録）

1. **「定理 X′ は塔の値へのフィットではないか」** → 違う。予言に使うのは $\mu$ と $\Lambda$ だけで、
   どちらも $p,q,\ell$ からの有限計算である（Step H1 に列挙）。
   Step F3 の照合は**全段が out-of-sample**。フィットで係数を解いた箇所は本 report に無い。
2. **「$\ell=2$ でも成り立つのではないか」** → 成り立たない（§9.3、Step H2）。
   使った 3 つの性質がどこで壊れるかを注 5.2 に明示した。
3. **「型 III は小さい $\ell$ の現象、という cycle 18 の読みは正しいか」** → 正しくない（§5.4、Step H3）。
   任意の奇素数で型 III の実例が構成できる。cycle 18 の観察は母集団の人工物である。
4. **「$\theta=\infty$ の点が $n\ell^n$ 項を作っているのではないか」** → 違う（命題 7、Step H4）。
   例外直線の寄与は $\lambda(\ell^n-1)+n\theta^*$ で $n\ell^n$ を含まない。
   $n\ell^n$ は近傍の「有限だが深い」点から出る。
5. **「例外直線の探索範囲が狭いから見落としているのではないか」** → 違う（命題 3、Step B2・H5）。
   有限性は Ostrowski から従う定理であって探索の結果ではない。
   広い箱（$|a|,|b|\le12$）でも Newton 差体の外に例外は出なかった。
6. **「定理 X′ の形は一般の塔でも成り立つのではないか」** → 成り立たない。
   **反例を確定させた**（§9.1、Step H6）。「まだ出来ていない」ではなく「何が妨げているか」を
   §9.1 に具体化した（$\bar E$ が 2 項式に分解するかどうか）。
7. **「命題 8 は本当に $\iff$ か（片側だけではないか）」** → $\iff$ である。
   最初に書いた命題 8 は実際に偽で、Step G2 の同値照合が 436 件の FAIL で検出した（§8.1）。
   訂正後の命題 8 は $144\times6$ 組すべてで一致する。
8. **「$\lambda,\theta^*$ が代表に依るなら定理 S は矛盾しないか」** → 矛盾しない。
   仮定 $\theta^*-m_1<\varphi(\ell^M)$ が成り立つ代表でしか使えず、
   複数の代表で仮定が成り立てば値は一致する（点の付値は代表に依らないので）。
   §2.6 に、仮定が破れる代表で誤用すると誤った値が出る具体例を挙げた。

---

## 12. 検証コード

`sagemath/check/cycle19_T3_theta_infinity/`（`overview.md` に対象ラベル、`README.md` に対象・手順・限界、
`RESULTS.md` に実行結果、`_defs19.sage` / `theta_infinity.sage` / `theta_infinity.out`）。

- **Step A**: 定理 S を円分体での独立な付値計算と照合。§2.6 の代表依存性の表も出力。
- **Step B**: 命題 2（判定条件、両辺を独立計算）と命題 3（Newton 差体への所属）。
- **Step C**: 補題 4（スケール不変性）。
- **Step D**: 系 5（同居構造の計数）。
- **Step E**: 系 6（例外方向では一般点も $\theta\ge\ell+1$）。
- **Step F**: 定理 X（F1 全点）、$\Sigma_n$（F2）、定理 X′（F3、塔の値と照合）、
  命題 7（F4）、命題 9（F5）。
- **Step G**: 母集団 566 塔の全走査による分類。G2 は命題 8 の全組合せ照合。
- **Step H**: 敵対的レビュー H1–H6（H6 が §9.1 の反例）。

実装は cycle 18 の `_defs18.sage`（さらにその土台の cycle 16 `_defs.sage`）を `load` しており、
**塔の値・点ごとの付値の計算は本サイクルの理論と独立**である。
