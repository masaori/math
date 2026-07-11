# 未解決問題（本プロジェクトのスコープ）

ここまでのスコープ——RΛ 双対（[`../R-Lambda-duality/`](../R-Lambda-duality/README.md)）、Mahler 測度＝$L$ 値（[`../Boyd-Deninger-Beilinson/`](../Boyd-Deninger-Beilinson/README.md)、[`../数え上げエントロピーと特殊値/`](../数え上げエントロピーと特殊値/README.md)）、曲面群のスペクトル曲線（[`../曲面群スペクトル曲線_球面とトーラス/`](../曲面群スペクトル曲線_球面とトーラス/README.md)）、$\mathbb{R}$ 脱出分類（[`../スペクトル多様体のR脱出分類/`](../スペクトル多様体のR脱出分類/README.md)）——に現れる**未解決問題**を、文献照合のうえ体系化する。証明済み/部分的/未解決を分別し（[E]/[部分]/[未解決]）、arXiv 番号を併記。**本プロジェクトの Λ-native 決定可能性の強みが効く標的**を最後に明示する（2026-07 時点）。

---

## 0. 組織原理：RΛ の二素点 × 幾何

RΛ 双対は「同一対象を $\infty$（$\mathbb{R}$：自由エネルギー・Mahler 測度）と各 $p$（$\Lambda$：$p$ 進エントロピー・$\mu_p$）で読む」。未解決問題もこの二素点＋幾何の4軸に分かれる。

| 軸 | ファイル | 中心の未解決問題 | 本プロジェクト適性 |
|---|---|---|---|
| **$\mathbb{R}$ 側（$\infty$）** | [`01_R側_アルキメデス.md`](01_R側_アルキメデス.md) | Lehmer, Boyd–Deninger, Beilinson(wt2/3/4), Chinburg | 検出のみ（閉形式は非可算・深い）|
| **$\Lambda$ 側（$p$）** | [`02_Λ側_p進とΛ.md`](02_Λ側_p進とΛ.md) | $p$ 進 Beilinson, 非可換 $p$ 進エントロピー, 非可換 balance, 有効 SML | **native（決定可能・可算）★** |
| **幾何・スペクトル曲線** | [`03_幾何とスペクトル曲線.md`](03_幾何とスペクトル曲線.md) | 高次 Hitchin(Chen–Ngô), 可換三つ組の可約性, P=W(一般 $G$), Painlevé/Garnier/wild | 部分的（$\mathbb{F}_q$ 点数側）|
| **双曲・非従順（$g\ge2$）** | [`04_双曲非従順と本プロジェクトの標的.md`](04_双曲非従順と本プロジェクトの標的.md) | 非従順塔の $p$ 進 $L^2$-torsion, sofic entropy $\Sigma$ 独立性, 双曲バンド完全性 | **headline 標的 ★★** |

**核心の非対称（全軸共通）**：$\Lambda$ 側は原理的に**決定可能・可算**（点数・Newton 多角形・$\mu_{\min}$・$v_p(a_L)$）。決定不能・閉形式なしは $\mathbb{R}$ 側 $m(P)$ に局在。ゆえ多くの未解決問題は「$\Lambda$ 側で検出可能な量を、$\mathbb{R}$ 側の閉形式（$L$ 値・体積）と結ぶ」形をとる。本プロジェクトの寄与は $\Lambda$ 側の**決定可能なプローブ**を与えること（[`../R-Lambda-duality §9.2`](../R-Lambda-duality/README.md)）。

---

## 1. 最重要未解決問題ランキング（全軸横断・上位15）

★＝本プロジェクトの Λ-native アプローチが直接効く標的。

| # | 問題 | 軸 | 状態 | 出典 |
|---|---|---|---|---|
| 1 | **Lehmer 問題**：$\inf\{m(P):m(P)>0\}>0$? | $\mathbb{R}$ | 未解決（90年）| Lehmer 1933 |
| 2 | **Boyd–Deninger 予想**：tempered $P$ で $m(P)\in\mathbb{Q}^\times L'(E,0)$ | $\mathbb{R}$ | 未解決（散発証明）| Boyd 1998, Deninger 1997 |
| 3 | **Beilinson 予想**（一般楕円 $K_2\to L(E,2)$、K3 wt3、CY wt4）| $\mathbb{R}$ | 未解決（modular/CM のみ）| Beilinson 1985 |
| 4 ★★ | **非従順塔の $p$ 進 $L^2$-torsion・非可換 $\mu_p$・balance formula**（双曲・曲面群 $g\ge2$）| $\Lambda$/双曲 | **未解決・文献に不在** | Ueki 2020 の非可換化 |
| 5 ★ | **$p$ 進 Beilinson**：$m_p$・$h_p$ を $p$ 進 $L$ 値として解釈 | $\Lambda$ | 未解決（散発）| Besser–Deninger 1999 |
| 6 ★ | **非可換 $p$ 進エントロピー / $p$ 進 FK 行列式の存在判定** | $\Lambda$ | 未解決 | Deninger 2009 |
| 7 | **高次元 Hitchin 写像**：完全可積分系は存在するか（$\dim X\ge2$）| 幾何 | 未解決（spectral data 全射は部分解決）| Chen–Ngô 2020 |
| 8 | **P=W 予想（一般簡約群 $G$）** | 幾何 | 未解決（$GL_n$ は 2022 解決）| dCHM 2012 |
| 9 | **Chinburg 予想**：全 $L'(\chi_{-f},-1)$ が Mahler 測度 | $\mathbb{R}$ | 未解決（~26 導手の証拠）| Chinburg 1984 |
| 10 ★ | **Bergeron–Venkatesh（自明 $\mathbb{Z}$ 係数）**：torsion 成長＝$L^2$-torsion | $\Lambda$/双曲 | 未解決（strongly acyclic のみ）| BV 2013 |
| 11 ★ | **有限表示剛群の指数的 $H_1$-torsion 成長の例が一つも無い** | $\Lambda$ | 未解決 | ABFG 2022 |
| 12 | **可換三つ組多様体 $C(3,n)$ の可約性ギャップ $9\le n\le28$** | 幾何 | 未解決 | Ngô–Šivic |
| 13 ★ | **有効 Skolem–Mahler–Lech**（$v_p(a_L)$ スパイクの決定）| $\Lambda$ | 未解決（$p$ 進は条件付き可）| Skolem 1934; Bacik et al. 2025 |
| 14 | **HLRV mixed Hodge 予想**（指標多様体、Macdonald）| 幾何 | 未解決（$E$-多項式は証明）| HLRV 2011 |
| 15 | **正則 Garnier $N\ge2$・wild P=W の一般分類** | 幾何 | 未解決 | Diarra–Loray; Szabó |

**本プロジェクトの3つの primary target**（[`04`](04_双曲非従順と本プロジェクトの標的.md) §4 で詳述）：**#4（非可換 balance）・#5（$p$ 進 $L$ 値）・#6（非可換 $p$ 進エントロピー）**——RΛ 双対の $L$ 値レッグ・定義レッグ・非可換幾何レッグ。#4 は既存 doc（[`../数え上げエントロピーと特殊値/06 §6`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md), [`07`](../数え上げエントロピーと特殊値/07_曲面群のスペクトル曲線_Λ言語.md)）が「自然な標的」と名指したものと一致し、最新文献が「文献に不在」と確認。

---

## 2. ファイル一覧

- [`01_R側_アルキメデス.md`](01_R側_アルキメデス.md) — Lehmer 問題（Dobrowolski–Voutier、Schinzel–Zassenhaus は Dimitrov 2019 で解決も Lehmer は別）、Boyd 予想（証明済み導手 11–36 vs 未解決）、Beilinson（wt2 modular/CM のみ、wt3/4 ほぼ全未解決）、Chinburg、Kontsevich–Zagier 周期、higher/zeta Mahler 測度。
- [`02_Λ側_p進とΛ.md`](02_Λ側_p進とΛ.md) — $p$ 進 Mahler 測度（$d\ge2$ で閉形式なし）、$p$ 進 Beilinson、非可換 $p$ 進 FK 行列式の存在判定、Ueki balance の非可換化、LSW 周期点 $a_L$ 収束（cubical は Dimitrov 2016 解決、一般は未解決）、有効 SML、Lück torsion 近似。**本プロジェクトの native 領域**。
- [`03_幾何とスペクトル曲線.md`](03_幾何とスペクトル曲線.md) — 高次元 Hitchin（Chen–Ngô 全射性：rank2 全次元・K3-trivial 解決、完全可積分系は未解決）、可換 $d$-組の可約性（$C(3,n)$ ギャップ $9\le n\le28$）、P=W（$GL_n$ 解決・一般 $G$ 未解決）、Painlevé/Garnier/wild、Deligne–Simpson（tame 解決・分岐 irregular 未解決）。
- [`04_双曲非従順と本プロジェクトの標的.md`](04_双曲非従順と本プロジェクトの標的.md) — 非従順塔の $p$ 進 $L^2$-torsion（**文献ギャップ＝headline 標的**）、sofic entropy の $\Sigma$ 独立性、Bergeron–Venkatesh、双曲バンド理論の完全性（非可換 Bloch 状態）、そして**本プロジェクトが取るべき標的の分析**。

---

## 3. 出典の総括

各ファイルに詳細。主要サーベイ：Smyth (2008) *Mahler measure survey*（arXiv:math/0701397）; Brunault–Zudilin (2020) *Many Variations of Mahler Measures*; Deninger (2009) *p-adic entropy…*（arXiv:math/0608539）; Ueki (2020) ETDS 40（arXiv:1702.03819）; Chen–Ngô (2020) Duke 169（arXiv:1905.04741）; Maulik–Shen (2024) Annals 200（arXiv:2209.02568）; Lisovyy–Tykhyy (2014) JGP 85（arXiv:0809.4873）; Abert–Bergeron–Fraczyk–Gaboriau (2022)（arXiv:2106.13051）.

**注意**：状態タグ・導手・arXiv 番号は 2026-07 時点の文献照合。P=W（$GL_n$）・Schinzel–Zassenhaus・PVI 代数解分類は近年解決、Lehmer・Beilinson 高 weight・非可換 balance は未解決。細部（一部前因子・ページ番号）は一次資料で最終確認を推奨。
