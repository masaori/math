# 頂点模型（vertex models）

頂点模型の定義・分類・高次元化・一般グラフ化のまとめ。可積分格子模型研究（`docs/research/R-Lambda-duality/`, `docs/research/可積分格子モデル一覧.md` ほか）の土台。

**頂点模型とは**: 格子（一般にはグラフ）の**辺**に状態を載せ、各**頂点**にその周りの辺状態の関数として Boltzmann 重みを与える模型。分配関数は全辺配置にわたる頂点重みの積の総和。次数（配位数）$q$ の頂点では重みは階数 $q$ のテンソルで、分配関数はグラフ上の**テンソルネットワークの縮約**。可積分（厳密可解）なものは重み空間の中で Yang–Baxter（頂点）／星-三角（スピン・面）関係が成り立つ部分多様体に限られる。

---

## 記述上の原則（本リポジトリ共通・厳守）

1. **数学的厳密性**: すべての記号の所属集合を明示（辺状態集合 $S$、重み $\in\mathbb{C}$ or $\mathbb{R}_{\ge0}$、可積分条件の住む空間）。
2. **比喩を使わない**。
3. **確立（定理級）と予想／未解決を都度分ける**。とくに「一般の十六頂点は非可積分」は**証明ではなく解の不在**（folklore）であることを明記。

---

## 全体像

| 次元・格子 | 頂点の配位数 $q$ | 局所配置数 | 可積分条件 | 代表 |
|---|---|---|---|---|
| 2D 正方格子 | 4 | $\lvert S\rvert^4$ | Yang–Baxter 方程式 | 六・八・十六頂点, 19頂点 |
| 2D 蜂の巣 | 3 | $\lvert S\rvert^3$ | 星-三角（三角格子と双対）| 八頂点=Ising in field |
| 2D 三角 | 6 | $\lvert S\rvert^6$ | 星-三角 | 20頂点(ice型) |
| 3D 立方 | 6 | $\lvert S\rvert^6$ | **テトラヘドロン方程式** | Zamolodchikov, Bazhanov–Baxter |
| $d$D 超立方 | $2d$ | — | **$d$-単体方程式** | 稀（$d\ge4$ はほぼ未知）|
| 一般平面グラフ | 可変 | — | Z-不変性・等半径 | Z-不変 Ising/八頂点, dimer |

**単体方程式の階層**: Yang–Baxter（2-単体＝三角形, 2D）→ テトラヘドロン（3-単体, 3D）→ $d$-単体（$d$D）。次元が上がるほど解は激減。

---

## ファイル一覧

- [00_定義と一般枠組み.md](00_定義と一般枠組み.md) — 頂点模型の厳密な定義、辺状態・重み関数・分配関数、テンソルネットワーク視点、$R$ 行列と Yang–Baxter、六頂点・八頂点の完全な図式的定義。
- [01_2次元正方格子の分類.md](01_2次元正方格子の分類.md) — 2 状態辺での 16/8/6/5/2 頂点階層と保存則（$U(1)$ ice rule / $\mathbb{Z}_2$ / 無）、自由フェルミオン条件（Fan–Wu）、高スピン（19頂点 ZF・IK）、量子群による分類。
- [02_高次元_テトラヘドロン方程式.md](02_高次元_テトラヘドロン方程式.md) — 3D 頂点模型、Zamolodchikov 模型、テトラヘドロン方程式、Baxter の証明、Bazhanov–Baxter（$\mathbb{Z}_N$）・Bazhanov–Stroganov、$d$-単体方程式、量子群・3D consistency、現状（解の稀少性）。
- [03_非正方格子と一般グラフ.md](03_非正方格子と一般グラフ.md) — 蜂の巣・三角・kagome、IRF/面模型（SOS・RSOS/ABF・hard hexagon）、頂点-面対応、Baxter の Z-不変性・星-三角、等半径グラフと離散正則性、dimer（Kasteleyn/KOS）、ランダム・双曲・高種数格子。

---

## 主要文献（各ファイルに詳細）

- R. J. Baxter, *Exactly Solved Models in Statistical Mechanics*, Academic Press (1982). — 全体の標準教科書。
- E. H. Lieb (1967), B. Sutherland (1967) — 六頂点の厳密解。
- R. J. Baxter (1971, 1972) — 八頂点の厳密解（楕円）。
- C. Fan, F. Y. Wu (1970) — 自由フェルミオン条件。
- A. B. Zamolodchikov (1980, 1981) — 3D 模型・テトラヘドロン方程式。
- A. Kuniba, *Quantum Groups in Three-Dimensional Integrability*, Springer (2022). — 3D 可積分性の現代的標準書。
- D. Chelkak, S. Smirnov (2012) — 等半径グラフ上の臨界 Ising の普遍性。
- R. Kenyon, A. Okounkov, S. Sheffield (2006) — dimer とスペクトル曲線・amoeba。
