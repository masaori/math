# 経路: 代数力学（群環と Mahler 測度）

**一言**: この経路が、本リポジトリの既存プログラム
（[`docs/research/R-Lambda-duality/`](../../../docs/research/R-Lambda-duality/)）と**直接つながる**。
線形 CA の規則は文字通り群環の元であり、そのエントロピーは Mahler 測度であり、
Mahler 測度はアルキメデス素点と $p$ 進素点で別々の量を与える——
これは $\mathbb{R}/\Lambda$ 双対そのものである。

## CA のモノイドと群環

### Curtis–Hedlund–Lyndon

群 $G$、有限アルファベット $A$。$A^G$ に積位相を入れると

$$
\mathrm{CA}(G,A)=\{F:A^G\to A^G\ \mid\ F\text{ は連続かつ }G\text{-同変}\}
$$

これがモノイド（合成について）をなす。舞台グラフは $G$ の Cayley グラフ。

### 線形 CA ＝ 群環の元（この経路の核心）

アルファベットを体 $K$（本プロジェクトでは主に $K=\mathbb{F}_2$）とし、$K$-線形な CA に限ると：

$$
\boxed{\ \mathrm{LCA}(G,K)\ \cong\ K[G]\ }\qquad(\text{群環。合成 }\longleftrightarrow\text{ 環の積})
$$

より一般に、アルファベットが $K^n$ なら $\mathrm{LCA}(G,K^n)\cong M_n(K[G])$。
（Ceccherini-Silberstein–Coornaert, *Cellular Automata and Groups*, Springer, 2010／2nd ed. 2024）

**これは本プロジェクトが探している「CA 規則 ↔ 代数構造」の対応の、最も純粋な形である**：

| CA 側 | 群環側 |
|---|---|
| 舞台グラフ（$G$ の Cayley グラフ） | 群 $G$ |
| 局所規則の近傍 | 群環の元の**台**（有限） |
| 局所規則の係数 | 群環の元の**係数** |
| 規則の合成 | 環の**積** |
| 恒等規則 | $1\in K[G]$ |
| シフト | 群元 $g\in G$ |
| **可逆性** | **単元群 $K[G]^\times$ に属すること** |

### 可逆性 ↔ 単元（帰結）

$G=\mathbb{Z}^d$、$K$ が体のとき $K[\mathbb{Z}^d]=K[x_1^{\pm},\dots,x_d^{\pm}]$（Laurent 多項式環）は
整域で、その単元は $c\,x^{a}$（$c\in K^\times$、$a\in\mathbb{Z}^d$）に限る。したがって

> **$\mathbb{Z}^d$ 上・体アルファベットの可逆な線形 CA は、シフトのスカラー倍しかない。**

$K$ を体でない環（例 $\mathbb{Z}_m$、$m$ が合成数）に替えると単元が増え、非自明な可逆線形 CA が出る
（Manzini–Margara による $\mathbb{Z}_m$ 上の可逆性判定と逆写像の明示公式）。
一般の群 $G$ に対する $K[G]^\times$ の決定は **Kaplansky の単元予想**の領域。

**帰属**: すべて可算・代数的。$\mathbb{Z}^d$ 上の可逆性判定は Laurent 多項式が単元かの判定で決定可能。

### Garden of Eden と従順性（舞台グラフが効く場所）

- **Moore–Myhill / Ceccherini-Silberstein–Machì–Scarabotti**:
  $G$ が**従順**なら、CA について「全射 $\iff$ pre-injective」。
- $G$ が**非従順**なら両者は独立になり、非 pre-injective で全射な線形 CA が構成できる。
- 双曲平面上の CA では GOE 定理が破れる。
- Gromov–Weiss: **sofic 群は surjunctive**（単射 ⇒ 全射）。全群が surjunctive か
  （Gottschalk 予想）は未解決。

**リポジトリとの接続**: [`docs/research/従順群と非従順群の基礎論/`](../../../docs/research/従順群と非従順群の基礎論/)
に従順性の基礎論があり、非従順（双曲）格子上の統計力学が
[`docs/research/数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md`](../../../docs/research/数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md)
で扱われている。**GOE 定理の成否は「舞台グラフ ↔ 統計力学の振る舞い」の対応の既存例**である（→ 種「非従順グラフ上のCA」）。

## Martin–Odlyzko–Wolfram（1984）— 有限環上の代数的解析

Martin, Odlyzko, Wolfram, "Algebraic properties of cellular automata", *Comm. Math. Phys.* **93** (1984) 219–258。

- 加法的 CA（Rule 90 は $T(x)=x+x^{-1}$、Rule 150 は $T(x)=x^{-1}+1+x$）を、
  多項式 $T(x)\in\mathbb{F}_2[x^{\pm}]$ として扱う。
- 周期 $L$ の環上では、状態空間は $\mathbb{F}_2[x]/(x^L-1)$ で、時間発展は $T(x)$ 倍写像。
- **状態遷移図の完全な構造**（過渡長、サイクル長、サイクルの個数、木の形）が、
  $x^L-1$ の $\mathbb{F}_2$ 上の因数分解と $T(x)$ の乗法的位数という**代数的・数論的な量**で
  書き下される。

**帰属**: サイクル長は $\mathbb{F}_2[x]/(x^L-1)$ の単元群における位数＝**$\mathbb{N}$ 値、決定可能**。
すべて有限体上の計算で、$\mathbb{R}$ は現れない。

**本プロジェクトにとっての意味**: 「規則という多項式の数論的性質が、力学の大域構造を決める」——
これはまさに `R-Lambda-duality` の「charpoly の Newton 多角形が $\Phi_N$ の構造を決める」と
同じ形の主張である。両者を並べる作業が空白（→ 種「線形CAとMahler測度」）。

## 代数力学：エントロピー ＝ Mahler 測度

### Ledrappier の例

$$
X=\Big\{x\in\mathbb{F}_2^{\mathbb{Z}^2}\ :\ x_{m,n}+x_{m+1,n}+x_{m,n+1}=0\ \ \forall (m,n)\Big\}
$$

これは Rule 90 型の加法的 CA の**時空図全体**のなす集合であり、$\mathbb{Z}^2$ 作用を持つ
コンパクト群。Ledrappier (1978) は、これが mixing だが 2-mixing でないことを示した。

**代数的な記述**: $X$ は $\mathbb{F}_2[x^\pm,y^\pm]/(1+x+y)$ の Pontryagin 双対。
**すなわち「CA 規則の多項式」がそのまま「代数力学系を定義する多項式」になっている。**

### Lind–Schmidt–Ward

Lind, Schmidt, Ward, "Mahler measure and entropy for commuting automorphisms of compact groups",
*Invent. Math.* **101** (1990) 593。

$\mathbb{Z}^d$ の代数的作用（$\mathbb{Z}[x_1^\pm,\dots,x_d^\pm]$-加群の双対）の位相的エントロピーは

$$
h=m(P)=\int_{\mathbb{T}^d}\log|P|\ \ (\text{Mahler 測度}).
$$

これが `R-Lambda-duality` の「自由エネルギー ＝ スペクトル曲線の Mahler 測度」の
力学系版であり、**同一の定理**である。

**帰属**: $m(P)$ は一般に超越的（型「実現の脱出」+「極限・積分」）。

### $p$ 進エントロピー（$\Lambda$ 側）

- Lind–Ward, "Automorphisms of solenoids and $p$-adic entropy",
  *Ergodic Theory Dynam. Systems* **8** (1988) 411 — エントロピーが**素点にわたる和**で書ける。
- Deninger (2009), "$p$-adic entropy and a $p$-adic Fuglede–Kadison determinant" —
  Lind–Schmidt–Ward の $p$ 進版。
- Besser–Deninger, "$p$-adic Mahler measures", *J. reine angew. Math.* **517** (1999) 19。
- 岩澤塔 $L=p^n$ における $v_p$ の線形成長率 ＝ $p$ 進エントロピー ＝ 岩澤 $\mu_p$ 不変量。

**これは `R-Lambda-duality/README.md` §4.2 でリポジトリが既に到達している地点である。**
CA はこの構造の最も具体的な供給源だが、**CA の文献と $p$ 進エントロピーの文献は交わっていない**（→ 種「線形CAとMahler測度」）。

## 線形 CA のエントロピーは $\Lambda$ に住む（$\mathbb{R}$ 脱出なし）

D'Amico, Manzini, Margara, "On computing the entropy of cellular automata",
*Theoret. Comput. Sci.* **290** (2003) 1629（ICALP'98 の拡張版）。

- 一般の CA について位相的エントロピーの計算（近似すら）は**アルゴリズム的に決定不能**
  （Hurd–Kari–Culik 1992、→ 「決定可能性」の経路）。
- しかし **$\mathbb{Z}_m$ 上の $D$ 次元線形 CA については閉じた公式があり、効率的に計算可能**。

**本プロジェクトにとっての要点**: この公式の値は、$m$ の素因数 $p$ にわたる
$\log p$ の非負整数結合の形をとる。すなわち

$$
h\ =\ \rho\Big(\sum_{p\mid m}c_p\,\ell_p\Big),\qquad c_p\in\mathbb{Z}_{\ge0},
$$

**$\Lambda$ の元を実現写像 $\rho$ で送っただけ**であり、超越的な Mahler 測度は現れない。

> **線形 CA は「統計力学のうち $\mathbb{R}$ 脱出が起きない部分」を切り出した対象**である。

（**要一次文献確認**: 係数 $c_p$ が常に非負整数か、$D\ge2$ や非素数 $m$ でも整数に留まるかは
原論文の公式で確認する。`sagemath/check/` の最初のタスクに含める。）

**対比**: 同じ多項式 $P$ から出る $\mathbb{Z}^2$ 作用（shift 方向を含む）のエントロピーは
Mahler 測度で一般に超越的。**時間方向（CA）は $\Lambda$、空間を含めた方向は $\mathbb{R}$**——
この非対称性は `R-Lambda-duality` の $\min$-$v_p$ と $\max$-$|\cdot|_\infty$ の対比と
同じ形をしている可能性がある（→ 種「線形CAとMahler測度」の核心）。

## この経路の空白

1. **線形 CA の $\mathbb{F}_2[x^\pm]$ と、格子模型のスペクトル曲線 $P(z,w)\in\mathbb{Z}[z^\pm,w]$ が
   同じ役割を果たしていることが、明示的に対応づけられていない。**
2. **「CA のエントロピーが $\Lambda$ に住む（線形）／計算不能（一般）」という二分法が、
   統計力学の自由エネルギーの言葉に翻訳されていない。**
3. **$p$ 進エントロピー（Deninger）を CA の側から計算した例が見当たらない。**
   Ledrappier の例は最も自然な試験台のはず。
4. **群環 $K[G]$ の単元問題（可逆 CA）と、統計力学の可解性の関係が問われていない。**
