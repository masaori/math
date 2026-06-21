# Lee–Yang / Fisher 零点プログラム

分配関数 $Z$ の**零点**（複素フガシティ／複素磁場における Lee–Yang 零点、複素温度における Fisher 零点）を通して相転移を論じる研究プログラムの理解ノート。

[対数順序群上の統計力学](../対数順序群上の統計力学/README.md)（以下「本プロジェクト」）の [05](../対数順序群上の統計力学/05_相転移はΦで論じられるか.md)（相転移の足跡）・[06](../対数順序群上の統計力学/06_文献調査_Ising臨界指数.md)（文献調査）で「実体は Lee–Yang/Fisher 零点プログラム」と同定された対象を、独立に詳しく理解するために切り出した。

## このプログラムの一言

**有限系の分配関数は整数係数多項式 $Z_N\in\mathbb{Z}[x]$（または $\mathbb{Z}[z]$）であり、その根（零点）は代数的数 $\in\overline{\mathbb{Q}}$。相転移とは「$N\to\infty$ で零点列が物理的な正実軸へ詰め寄り、極限で実軸を貫く（pinch）」現象である。** 自由エネルギーの非解析性を、解析関数の議論ではなく**多項式の根の配置**に翻訳する。

- **Lee–Yang 零点**（Yang–Lee 1952）：複素**磁場／フガシティ**平面 $z=e^{-2\beta H}$ の零点。強磁性 Ising では円定理により全零点が単位円 $|z|=1$ 上（[01](01_Lee-Yang円定理.md)）。
- **Fisher 零点**（Fisher 1965）：複素**温度**平面の零点（磁場 $0$）。2 次元正方 Ising では 2 円 $|z\pm1|=\sqrt2$（$z=e^{2K}$）上（[03](03_Fisher零点と2DIsing厳密.md)）。

## なぜ本プロジェクトにとって重要か

本プロジェクトは「核は可算（$\Lambda$・$\mathbb{Z}[x]$・$\overline{\mathbb{Q}}$）、$\mathbb{R}/\mathbb{C}$ 脱出は最後だけ」を主張する。零点プログラムはまさに**相転移を可算・代数的データ（整係数多項式の根）に翻訳する**装置であり、本プロジェクトの主張の最大の実例かつ前例になる。本プロジェクト固有の差分は「これを明示的に $\overline{\mathbb{Q}}$ の言明・$\mathbb{Q}$ 上の量化言明として書く」点（[07](07_可算代数的再定式化_本プロジェクトとの接続.md)、[06 文献](../対数順序群上の統計力学/06_文献調査_Ising臨界指数.md) §3）。

## ファイル一覧

- [00_零点プログラムとは_全体像.md](00_零点プログラムとは_全体像.md) — 分配関数を多項式として見る視点。2 種の零点（Lee–Yang／Fisher）の定義と変数の住処。プログラムの論理（有限は滑らか→列→pinch→転移）。
- [01_Lee-Yang円定理.md](01_Lee-Yang円定理.md) — 円定理（1952）。強磁性 Ising で全零点が $|z|=1$。Asano 縮約による証明の骨子。何を仮定し何が代数的か。
- [02_零点と相転移_密度と電荷アナロジー.md](02_零点と相転移_密度と電荷アナロジー.md) — 自由エネルギー $=$ 零点による対数ポテンシャル。零点密度 $\rho=-\frac1{2\pi}\nabla^2(\beta f)$（2 次元静電アナロジー）。ギャップ $\theta_e$・pinch・転移の次数。
- [03_Fisher零点と2DIsing厳密.md](03_Fisher零点と2DIsing厳密.md) — 複素温度の零点。2 次元 Ising の厳密な軌跡（2 円）、密度の線形消失 → 対数比熱、自己双対臨界点 $\tanh K_c=\sqrt2-1$。
- [04_Lee-Yang_edge_singularityと非ユニタリCFT.md](04_Lee-Yang_edge_singularityと非ユニタリCFT.md) — ギャップの端 $\theta_e$ の臨界性。edge 指数 $\sigma$、$\rho\sim|\theta-\theta_e|^\sigma$、虚カップリング $\phi^3$、非ユニタリ極小模型 $M(2,5)$。
- [05_有限サイズスケーリングと臨界指数抽出.md](05_有限サイズスケーリングと臨界指数抽出.md) — Itzykson–Pearson–Zuber の FSS。先頭 Fisher 零点 $\sim L^{-1/\nu}$、先頭 Lee–Yang 零点 $\sim L^{-y_h}$、$y_h=(d+2-\eta)/2$。指数抽出の論理。
- [06_キュムラント法による零点抽出.md](06_キュムラント法による零点抽出.md) — 観測量の高次キュムラントから先頭零点を読む（Flindt–Garrahan）。$\kappa_n\simeq(-1)^{n-1}(n-1)!\,2\cos(n\arg s_0)/|s_0|^n$、4 連続キュムラントの線形系。
- [07_可算代数的再定式化_本プロジェクトとの接続.md](07_可算代数的再定式化_本プロジェクトとの接続.md) — $Z_N\in\mathbb{Z}[x]$・零点 $\in\overline{\mathbb{Q}}$・円定理＝代数的言明・転移＝$\mathbb{Q}$ 上の量化言明。どこまで可算でどこから $\mathbb{R}/\mathbb{C}$ か。本プロジェクトの差分。

## 集合帰属の早見表（プログラム全体）

| 対象 | 帰属 | 意味 |
|---|---|---|
| $Z_N(x)=\sum_m\Omega_N(m)x^m$ | $\mathbb{Z}[x]$ | 有限系分配多項式（係数＝配置数 $\in\mathbb{N}$） |
| 零点 $x_j$（Lee–Yang／Fisher） | $\overline{\mathbb{Q}}$ | 整係数多項式の根（代数的、$\mathbb{Z}[x]$ の分解体） |
| 円定理 $\lvert z_j\rvert=1$ | $\overline{\mathbb{Q}}$ 上の代数的言明 | 根の所在（実閉体の述語） |
| 臨界点 $x_c$（集積点の値） | $\overline{\mathbb{Q}}$ | 自己双対点等で代数的（例 $\sqrt2-1$） |
| 「零点が正実軸へ詰め寄る」 | $\mathbb{Q}$ 上の量化言明 | $\forall\epsilon\in\mathbb{Q}_{>0}\,\exists N\,\exists j:\mathrm{dist}(x_j,\mathbb{R}_{>0})<\epsilon$ |
| 零点密度 $\rho$・edge 指数 $\sigma$・$\nu,\eta$ | $\mathbb{R}$ | $N\to\infty$ の連続極限・非解析性 |

## 主要文献（入口）

- Yang & Lee, *Phys. Rev.* **87** (1952) 404 / 410（円定理）。
- Fisher (1965, Boulder lectures)（複素温度零点）。
- Itzykson, Pearson & Zuber, *Nucl. Phys. B* **220** (1983) 415（零点の FSS）。
- Fisher, *Phys. Rev. Lett.* **40** (1978) 1610（edge ＝虚 $\phi^3$）。Cardy, *PRL* **54** (1985) 1354（$M(2,5)$）。
- 零点密度（2D Ising 厳密）：arXiv:cond-mat/0001409。
- キュムラント法：Flindt & Garrahan, *PRL* **110** (2013) 050601（arXiv:1209.2524）。
- 普遍臨界指数の抽出：Deger & Flindt, *Phys. Rev. Research* **1** (2019) 023004（arXiv:1905.02379）。
- 2D Ising の Padé による零点：arXiv:2312.03178。
</content>
</invoke>
