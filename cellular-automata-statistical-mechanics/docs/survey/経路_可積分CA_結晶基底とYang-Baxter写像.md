# 経路: 可積分 CA（結晶基底と Yang–Baxter 写像）

**一言**: 可解格子模型を $q\to0$（結晶化）または ultradiscrete 極限で潰すと、
**残るのは有限集合上の組合せ的な CA 規則**である。この経路では
「CA 規則 ↔ 代数構造」の対応が**最も明示的に、しかも $\mathbb{R}$ 脱出ゼロで**成立している。

## 箱玉系（box–ball system, BBS）

Takahashi–Satsuma (1990) が導入した 1 次元 CA。箱の列に玉を置き、
「左から順に、各玉を右隣の最も近い空箱へ移す」という規則で更新する。

- ソリトン（玉の塊）が存在し、**大きい塊が小さい塊を追い越すときに位相のずれだけを残して
  形を保つ**——KdV ソリトンと同じ散乱の様相。
- **二重の起源**（Inoue–Kuniba–Takagi のレビューの表現）:
  - **ultradiscretization**（古典可積分系 → CA）: 離散 KdV 方程式を
    $x\mapsto\lim_{\varepsilon\to0}\varepsilon\log(e^{X/\varepsilon}+e^{Y/\varepsilon})=\max(X,Y)$
    で max-plus 化すると BBS が出る。
  - **crystallization**（量子可積分系 → CA）: $U_q(\widehat{\mathfrak{sl}}_n)$ の頂点模型で
    $q\to0$ を取ると、$R$ 行列が**組合せ $R$**（有限集合上の全単射）に退化し、
    その転送行列が BBS の時間発展を与える。

### 代数構造の対応（この経路の中核）

| CA 側 | 代数構造 |
|---|---|
| 状態（箱の中身） | 結晶 $B$ の元（$U_q'(\mathfrak{g})$-結晶基底、$q=0$） |
| 時間発展 1 ステップ | 結晶の転送行列（組合せ $R$ の積） |
| **ソリトンの散乱則** | **$U_q'(\mathfrak{g})$-結晶の組合せ $R$ 行列** |
| 保存量 | エネルギー関数 $H$（結晶上の $\mathbb{Z}$ 値関数） |
| 初期値問題の解 | 組合せ Bethe 仮説（rigged configuration との全単射） |
| 一般化（$A_n^{(1)},C_n^{(1)},D_4^{(3)},G_2^{(1)},D_n^{(1)}$…） | 各アフィン量子群の結晶 |

**「CA 規則 ↔ 量子群の表現論」という対応がここでは完全に確立している。**
これが本プロジェクトの探す「対応パターン」の最も成功した既存例である。

### 可算性の観点（重要）

$q\to0$ の後に残るのは：

- 有限集合（結晶 $B$）
- その上の全単射（組合せ $R$）
- $\mathbb{Z}$ 値のエネルギー関数
- Yang–Baxter 関係式（有限個の等式）

**すなわち $\overline{\mathbb{Q}}$ すら不要で、すべてが有限・組合せ的・決定可能。**
元の頂点模型は $\mathbb{C}$ 上の $R$ 行列・楕円関数・Bethe 方程式（$\mathbb{R}/\mathbb{C}$ 全開）
だったのに、極限を取ると可算どころか有限に落ちる。

**これは「ultradiscretization ＝ 可算側への射影」という見方を強く示唆する**（→ 種「ultradiscretizationはΛ射影」）。
さらに、$p$ 進 Newton 多角形も「素点 $p$ でのトロピカル化」であり
（`docs/research/R-Lambda-duality/README.md` §8.1b）、
**アルキメデス側のトロピカル化＝ultradiscretization、$p$ 進側のトロピカル化＝Newton 多角形**
という二つのトロピカル影の対比が立つ。

## Yang–Baxter 写像（set-theoretical YBE）

Drinfeld が提起し Veselov が "Yang–Baxter map" と名付けた対象：
集合 $X$ 上の写像 $R:X\times X\to X\times X$ で braid 関係
$R_{12}R_{13}R_{23}=R_{23}R_{13}R_{12}$（$X^3$ 上）を満たすもの。

**局所規則が YB 写像であるようなブロック CA は超可積分（superintegrable）である**：
Gombor–Pozsgay, "Superintegrable cellular automata and dual unitary gates from Yang–Baxter maps",
*SciPost Phys.* **12** (2022) 102 (arXiv:2112.01854)。

- 指数関数的に多い**局所保存量**を持ち、電荷密度は弾道的に伝播する。
- これらの量について**演算子の広がり（operator spreading）が完全に消える**。
- 非退化な YB 写像は「双ユニタリゲート」の古典版になる（→ 「可解な決定論的CA」の経路）。
- 局所次元 $N\le4$ の具体模型で、非自明な粒子散乱、弾道輸送と拡散輸送の共存を示している。

### 可算性・決定可能性の観点（重要）

**有限集合 $X$（$|X|=n$）上の写像が YB 写像かどうかは、$n^6$ 個の等式の有限検査で決まる。**
すなわち

$$
\text{「この CA 規則は可積分か」}\ \text{は、有限記号操作で決定可能な述語になる。}
$$

これは通常の可積分性（$R$ 行列の族 $R(u)$ がスペクトルパラメータ $u\in\mathbb{C}$ について
YBE を満たす、という**連続体上の**条件）とは決定的に異なる。
**可積分性という概念が、CA の側では決定可能な有限条件に化ける**（→ 種「可解性は有限検査で決まる」）。

## 3D consistency と quad-graph

Bobenko–Suris らの離散可積分系の枠組み。

- quad-graph 上の方程式が「立方体まわりの整合性（consistency around a cube）」を満たすことが
  離散可積分性の定義になる。ABS 分類（Adler–Bobenko–Suris）はこの条件で方程式を分類した。
- **YB 関係式は 3D consistency の帰結である**（Papageorgiou–Tongas–Veselov ほか）。
- 「quad-graph 方程式と YB 写像は同じコインの裏表」。

**帰属**: 3D consistency も有限個の代数的恒等式であり、多項式方程式系として決定可能
（実閉体の量化消去 / Gröbner 基底）。舞台グラフを変えたときの整合性条件が
**グラフの局所構造（面・立方体）で書ける**点は、本プロジェクトの「舞台グラフ ↔ 代数構造」の
探索に直結する。

高次元版（テトラヘドロン方程式、Zamolodchikov）は `docs/research/頂点模型/02_高次元_テトラヘドロン方程式.md` に既にまとめがある。

## この経路の空白

1. **2 値（$|X|=2$）に限ったときの YB 写像の完全分類が、CA の言葉で書かれていない。**
   Gombor–Pozsgay は $N\le4$ を扱うが、$N=2$（2 状態）に絞って
   「初等 CA 256 個のうちどれが YB 写像に由来するか」という形の表はない（→ 種「可解性は有限検査で決まる」）。
2. **ultradiscretization を「可算化」として定式化した文献がない。**
   トロピカル幾何としての整理（Inoue–Kuniba–Takagi）はあるが、
   「$\mathbb{R}$ 脱出を除去する操作」としての位置づけは無い（→ 種「ultradiscretizationはΛ射影」）。
3. **$p$ 進トロピカル化（Newton 多角形）との対比が無い。**
   max-plus 半環 $(\mathbb{R},\max,+)$ の代わりに $(\Lambda,\max,+)$ を使う定式化は見当たらない。
