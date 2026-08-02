# 経路: 転送行列と確率的 CA（平衡統計力学への埋め込み）

**一言**: CA の時間発展方程式は、1 次元高い格子模型の転送行列そのものである。
この対応により、平衡統計力学の全道具（双対変換、無秩序解、相転移の理論）が CA に使える。

## 基本対応（Rujàn 1987）

Rujàn, "Cellular automata and statistical mechanical models", *J. Stat. Phys.* **49** (1987) 139–222
がこの経路の正典。要点：

- CA の時間発展を記述する**マスター方程式**と、通常の格子模型の**転送行列**は同じ構造を持つ。
- 確率的 CA の**過渡的性質** ↔ 制限された統計力学系の**表面性質**、
  **定常的性質** ↔ **バルク性質**。
- 得られる厳密結果: 双対変換、厳密写像、"disorder solution"（無秩序解）、"linear solution"。
- 逆向きの応用として、**望みの性質を持つ CA を統計物理から設計する**という視点を提示している。

### 具体的な構成

1 次元 CA、状態 $\sigma_i(t)\in\{0,1\}$、局所規則 $f$。時空図の重み

$$
W\big(\{\sigma(t{+}1)\}\,\big|\,\{\sigma(t)\}\big)=\prod_i \delta\big(\sigma_i(t{+}1),\,f(\sigma_{i-r}(t),\dots,\sigma_{i+r}(t))\big)
$$

は $\{0,1\}$ 値。この $W$ を転送行列 $T$ の行列要素とみなすと、$T\in M_{2^L}(\{0,1\})$（周期 $L$）。

$$
Z_N=\operatorname{Tr}T^N\ =\ \#\{\text{長さ }N\text{ の周期的時空履歴}\}\in\mathbb{N}.
$$

**決定論的 CA では $T$ の各列がちょうど 1 つの 1 を持つ**（列確率行列かつ $\{0,1\}$）ので、
$T$ は $\{0,1\}^L$ 上の写像の表現行列。可逆 CA なら $T$ は**置換行列**であり
$Z_N=\#\{\text{周期 }N\text{ の点}\}$、固有値はすべて 1 の冪根。

**帰属**: $T\in M_d(\mathbb{Z})$、$Z_N\in\mathbb{N}$、$\Phi_N=\log Z_N\in\Lambda$。
$\mathbb{R}$ 脱出はゼロ。これは `docs/research/R-Lambda-duality/` の定理 P がそのまま適用できる
最小の設定である（→ 種「Φ_N の台と代数的複雑度」）。

## 確率的 CA と Gibbs 状態（Lebowitz–Maes–Speer 1990）

Lebowitz, Maes, Speer, "Statistical mechanics of probabilistic cellular automata",
*J. Stat. Phys.* **59** (1990) 117–170。

**中心的対応**:

$$
\Big\{\text{$\mathbb{Z}^d$ 上の PCA の時空履歴上の定常測度}\Big\}\ \longleftrightarrow\
\Big\{\text{$\mathbb{Z}^{d+1}$ 上のある Hamiltonian の並進不変 Gibbs 状態}\Big\}
$$

得られた結果：

- 時空履歴に対する簡明な**大偏差公式**。
- **高温領域で PCA の定常状態は Gibbs 的**であることの証明。
- エントロピー・ゆらぎ・相関不等式。
- 高ノイズ領域での不変測度の一意性と相関の指数減衰。
- 低ノイズ（低温）領域での相転移、および Toom の非エルゴード性証明の位置づけ。

関連: Goldstein–Kuik–Lebowitz–Maes, "From PCA's to equilibrium systems and back",
*Comm. Math. Phys.* **125** (1989) 71。逆向き（平衡系から PCA へ）の構成。

### 可算性の観点

PCA の遷移確率を $\mathbb{Q}\cap[0,1]$ に取ると、有限系のすべての量が $\mathbb{Q}$ に留まる。
`docs/discussion/対数順序群上の統計力学/00_記号と定義.md` §7 の
「カノニカル分布＝熱浴の状態数比 $\in\mathbb{Q}$、$\exp$ は導出物」という定式化と**そのまま整合する**。
すなわち **PCA は $\Lambda$ 上のカノニカル形式の自然な住処**である（→ 種「PCAはΛ上カノニカルの住処」）。

一方、Gibbs 対応の側で現れる $e^{-\beta H}$ は指数評価による $\mathbb{R}$ 脱出の脱出。
「PCA ↔ Gibbs」の対応において、PCA 側は $\mathbb{Q}$ で閉じ、Gibbs 側は $\mathbb{R}$ に出る——
**この非対称性は文献では意識されていない**。

## Domany–Kinzel と有向浸透（相転移・普遍類）

Domany–Kinzel (1984) の確率的 CA は $(1{+}1)$ 次元の有向浸透（DP）を実現する標準模型。

- 対角正方格子上、離散時間、並列更新、2 パラメータ $(p_1,p_2)$。
- $p_2=p_1(2-p_1)$ で有向ボンド浸透、$p_1=p_2$ で有向サイト浸透。
- 転移線上の臨界挙動は DP 普遍類（終端点のみ compact DP）。
- **DP 普遍類は Reggeon 場の理論（非ユニタリな QFT）と同じ**というのが古典的な対応
  （Cardy–Sugar 1980）。これは「CA → 場の理論」の最も古い明示的な橋の一つ。

**帰属**: 臨界指数はスケーリング極限（極限・積分による $\mathbb{R}$ 脱出）で定義され、可算側の代替は現時点で未知
（`docs/research/場の量子論の数学的定式化/10_可算性から見た場の量子論.md` の「臨界指数」の項）。

## 全射 CA・可逆 CA の統計力学

- **全射 CA は一様測度を保存する**（Hedlund）。したがって全射 CA の時空測度は
  最大エントロピー測度であり、「無限温度の平衡系」に対応する。
  Kari–Taati, "Statistical mechanics of surjective cellular automata", *J. Stat. Phys.* **160** (2015)。
- **可逆 CA の熱力学**: Takesue, "Reversible cellular automata and statistical mechanics",
  *Phys. Rev. Lett.* **59** (1987) 2499。ERCA（elementary reversible CA）は Liouville 定理
  （位相空間体積の保存）を満たし、**加法的保存量をエネルギーとみなすと統計力学が形式的に構成できる**。
  部分系＋熱浴の分解からカノニカル分布が実現する条件を論じている。
- 保存量の一般論: Hattori–Takesue, "Additive conserved quantities in discrete-time lattice
  dynamical systems", *Physica D* **49** (1991) 295。**加法的保存量の存在の必要十分条件**が
  有限手続きで書ける（→ 帰属は可算、決定可能）。

### 可算性の観点

保存量は「局所関数の有限和が時間発展で不変」という**線型条件**であり、
有限次元 $\mathbb{Q}$-線形代数で決定できる。保存量全体は $\mathbb{Z}$-加群（格子）をなす。
**これは CA 側で完全に可算・決定可能な構造**であり、
可積分系の保存量（無限個、超越的な生成関数）と対照的である。

## この経路の空白

1. **PCA 側（$\mathbb{Q}$）と Gibbs 側（$\mathbb{R}$）の非対称性が整理されていない。**
   どの Gibbs 的結論が $\mathbb{Q}$ 側だけで言えるか。
2. **$\{0,1\}$ 重みの転送行列に特化した数論的構造の研究がない。**
   $T\in M_d(\{0,1\})$ に対する $Z_N=\operatorname{Tr}T^N$ の $p$ 進構造は、
   `R-Lambda-duality` の枠組みでそのまま扱えるのに、CA の文献では扱われていない（種「Φ_N の台と代数的複雑度」）。
3. **可逆 CA の「エネルギー」（加法的保存量）が $\mathbb{Z}$ 値であることの帰結**が、
   $\Lambda$ 上の統計力学（$\beta\in\Lambda$、第〇法則）と接続されていない（種「PCAはΛ上カノニカルの住処」）。
