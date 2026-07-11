# 数え上げエントロピーと特殊値

**研究方向**: 数え上げ問題（$Z_N\in\mathbb{Z}_{>0}$）の中から、スペクトル曲線が数論的に特殊で成長率 $\lim\frac1N\log Z_N$ が**特殊値**（Mahler 測度・$L$ 値・周期）になるものを探す・分類する。

出どころ: `docs/research/R-Lambda-duality/` §9.4（ゴールの定式化）。この方向の**既存研究の広域リサーチ**を 4 領域で行い集約した（Web 検索で文献照合済み、確立 [E]／予想 [C/O] を分別）。

---

## 中心的事実（一枚に凝縮）

Laurent 多項式 $P$ の（対数）**Mahler 測度** $m(P)=\int_{\mathbb T^n}\log|P|\,d\mu$。周期的な数え上げ問題の成長率は
$$
\lim_{N\to\infty}\tfrac1N\log Z_N=\log\lambda_{\max}=m(P)\quad(P=\text{スペクトル曲線}).
$$
極限の**存在**はほぼ常に成立（Lind–Schmidt–Ward：$\mathbb{Z}^d$ 作用の位相的エントロピー＝Mahler 測度）。問いは「極限が**特殊値／閉形式か**」＝**曲線 $\{P=0\}$ の数論型**：

| $\{P=0\}$ の型 | $m(P)$ の閉形式 | 例 |
|---|---|---|
| 有理（種数0）| Dirichlet $L$ 値・$\zeta(3)$・dilog | $\mathbb{Z}^2$ 全域木 $\frac4\pi\beta(2)$、正方 dimer $\frac{G}{\pi}$、Smyth $m(1{+}x{+}y)$ |
| 楕円（種数1）| $r\,L'(E,0)$（Boyd–Deninger）| Ising 一般温度、$m(1{+}x{+}\frac1x{+}y{+}\frac1y)=L'(E_{15},0)$ |
| K3（3変数）| weight-3 modular $L(f,3)$ | Bertin, Samart |
| Calabi–Yau（4変数）| weight-4 modular $L$ | Papanikolas–Rogers–Samart |
| 高種数・非可積分 | 一般に閉形式なし（"generic"）| hard-square, $\mathbb{Z}^2$ SAW, 格子動物 |

**核の主張**: 「エントロピー＝Mahler 測度＝周期」は**定理**（LSW/Lyons/KOS）。「周期＝特殊 $L$ 値」への精密化は**大きく予想的だが多数の証明例**をもつ数論プログラム（Boyd/Deninger/Beilinson）。**可積分だが非自由フェルミオン**（hard hexagon, square ice）は**代数的数**の別バケツ。**非可積分**は特殊値構造なし。

---

## ファイル一覧

- [00_総論_数え上げエントロピーは周期.md](00_総論_数え上げエントロピーは周期.md) — 全体像、エントロピー＝Mahler 測度＝高さ＝周期の辞書（LSW, Lyons, KOS, Everest–Ward, Deninger）、数論型による分類、確立/予想の切り分け、R-Λ 双対との接続。
- [01_Mahler測度とL値.md](01_Mahler測度とL値.md) — Mahler 測度＝$L$ 値の既知結果の landscape。Smyth・Boyd・Rodriguez-Villegas・Rogers–Zudilin・Brunault・Lalín（楕円）、Bertin・Samart（K3）、Papanikolas–Rogers–Samart（CY3）、tempered 条件、Chinburg 予想、higher/multiple Mahler 測度。
- [02_数え上げの成長率が特殊値になる例.md](02_数え上げの成長率が特殊値になる例.md) — 全域木（tree entropy＝Laplacian Mahler 測度, $\mathbb{Z}^2=\frac4\pi\beta(2)$）、dimer（KOS, 正方＝Catalan）、代数力学（LSW, 高さ辞書）、Ising、SAW 連結定数（蜂の巣＝$\sqrt{2+\sqrt2}$）、hard hexagon・square ice（代数的）、格子動物（generic）。
- [03_スペクトル曲線の数論とトロピカル.md](03_スペクトル曲線の数論とトロピカル.md) — dimer スペクトル曲線＝Harnack 曲線・amoeba＝相図（KOS, Kenyon–Okounkov）、種数＝ガス相数、Ising/八頂点/カイラル Potts（種数10）、トロピカル化（amoeba spine と $p$ 進 Newton 多角形＝共通骨格）、cluster 可積分系（Goncharov–Kenyon）、Newton 多角形＝master datum。
- [04_周期と特殊値の一般論.md](04_周期と特殊値の一般論.md) — Kontsevich–Zagier 周期、格子和・格子 Green 函数（Watson, Chowla–Selberg, Gamma/CM 周期）、Bessel moment、Feynman 積分＝周期（MZV/Brown, elliptic/modular, Calabi–Yau）、Ising 感受率（Fuchsian ODE, diagonal of rational functions, modular/CY）、分類プログラム（motivic Galois, cosmic Galois/coaction, globally nilpotent $G$-function）。
- [05_スペクトル曲線の定義.md](05_スペクトル曲線の定義.md) — スペクトル曲線を定義から：周期的作用素の Bloch–Fourier 変換 $A(z,w)$、$P(z,w)=\det A(z,w)$、曲線 $C=\{P=0\}$、固有値・分配関数・自由エネルギー（dimer で $=m(P)$、一般で LSW）、Newton 多角形・amoeba・種数・算術、具体例（蜂の巣 dimer＝直線／Ising＝楕円）。

---

## 主要文献（各ファイルに詳細）

- D. Lind, K. Schmidt, T. Ward (1990) — 位相的エントロピー＝Mahler 測度。
- R. Lyons (2005) — tree entropy＝Laplacian の正規化行列式。
- R. Kenyon, A. Okounkov, S. Sheffield (2006) — dimer とスペクトル曲線・amoeba・Harnack。
- C. Deninger (1997) — Mahler 測度＝Beilinson 正則子。
- D. Boyd (1998); Rogers–Zudilin (2014); Brunault; Lalín — Mahler 測度＝$L$ 値。
- F. Brunault, W. Zudilin (2020) — *Many Variations of Mahler Measures*（標準書）。
- G. M. Viswanathan (2024, arXiv:2407.19531) — Ising 自由エネルギー＝Mahler 測度・$L$ 値。
- M. Kontsevich, D. Zagier (2001) — Periods。
- F. Brown (2012) — mixed Tate motives over ℤ / MZV。
- Bostan–Boukraa–Christol–Hassani–Maillard (2013) — Ising $\chi^{(n)}$＝diagonal of rational functions。
