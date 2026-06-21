# 02. 厳密数値計算（SageMath）での効用

**主張**：有限格子の統計力学量（分配多項式 $Z_L(x)\in\mathbb{Z}[x]$、その零点、$\Phi_L=\log Z_L(q)\in\Lambda$、臨界点 $x_c$）は SageMath で**誤差ゼロ・決定可能・証明つき**に計算できる。浮動小数点に落ちるのは連続極限（Onsager 積分）だけで、その境界は統計力学ノートの脱出 (b) に一致する。

## 1. 厳密な環・体がそのまま使える

- `ZZ`（整数）、`QQ`（有理数）、`ZZ['x']`（整係数多項式）は丸め誤差なしの厳密演算。[S-C1]
- `QQbar`（代数的数の体＝$\overline{\mathbb{Q}}\hookrightarrow\mathbb{C}$）、`AA`（実代数的数）は公式ドキュメントいわく "All computations are exact"。[S-C2]
- 統計力学側の対象の帰属（[統計力学 09](../対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md) の台帳）が、そのまま Sage の厳密型に対応する：

| 統計力学の対象 | 帰属 | Sage の厳密型 |
|---|---|---|
| $\Omega_L(m)$ | $\mathbb{N}$ | `ZZ` |
| $Z_L(x)$ | $\mathbb{Z}[x]$ | `ZZ['x']` |
| $\Phi_L=\log Z_L(q)$ | $\Lambda$ | `Factorization`（指数ベクトル） |
| 零点・分散・$x_c$ | $\overline{\mathbb{Q}}$ | `QQbar`/`AA` |
| 自由エネルギー密度の積分 | $\mathbb{R}$ | `numerical_integral`（**非厳密**） |

## 2. 代数的数の比較・符号が厳密に決定可能

これが「$\Lambda$／$\overline{\mathbb{Q}}$ に絞る」最大の配当。

- `QQbar`/`AA` の元は **最小多項式＋孤立区間**で厳密表現される（`.minpoly()`、`polynomial_root(poly, interval)`）。[S-C3][S-C6][S-C7]
- 比較 `==`,`<`,`>` と符号は **厳密かつ決定可能**：まず 128bit 区間演算で試し、差が示せなければ**厳密計算にフォールバック**する。非等号は区間で、等号は記号計算で証明する遅延戦略。判定は heuristic でなく**証明つき (certified)**。[S-C4][S-C5]
- 対比：$\mathbb{R}$ 値（`RR`/`RDF`）の比較は浮動小数点で、等号は信用できない。$\overline{\mathbb{Q}}$ に留まる限りこの問題が起きない。[S-C16]

これは形式証明側の「$\Lambda$ の順序は整数比較で決定可能」（[01](01_自動証明_LeanCoq.md) §3）と同じ事実の、計算側の現れ。代数的数の符号判定が決定可能なのは Sturm 列・区間演算の理論的帰結（[01](01_自動証明_LeanCoq.md) §3.1 の RCF 決定可能性、[出典.md] [D-C11]）。

## 3. $\log$ ＝素因数分解、順序＝整数比較

- `Integer.factor()` は厳密な `Factorization`（$(p_i,e_i)$ のリスト）を返す。これが「正整数 → $\bigoplus_p\mathbb{Z}$ の指数ベクトル」写像＝$\log$ の実装そのもの。[S-C9]
- $p$ 進付値は `ZZ.valuation(p)` で厳密に取れる（指数 $e_i$）。整数の「大きさ比較」を**浮動小数点 $\log$ でなく付値・指数の整数比較**で行える。[S-C10]
- 自由 $\mathbb{Z}$ 加群は `FreeModule(ZZ, n)` / `ZZ^n`、整数格子 `IntegerLattice` として厳密に実装でき、$\Lambda$ の有限部分（有限個の素数だけ非零）をそのまま載せられる。[S-C8]

**手順**：有理点 $x=q\in\mathbb{Q}_{>0}$ で $Z_L(q)\in\mathbb{Q}_{>0}$ を厳密評価 → `factor()` で指数ベクトル → $\Phi_L\in\Lambda$ を誤差ゼロで得る（[統計力学 09](../対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md) Step 1 の例 $Z_{C_4}(1/2)=41/8=2^{-3}\cdot41$、$\Phi=\ell_{41}-3\ell_2$ がそのまま Sage で再現できる）。

## 4. $\mathbb{Z}[x]$ 零点（Fisher/Lee–Yang）の厳密化

- `.roots(ring=QQbar)` / `.roots(ring=AA)` は**厳密な代数的根**を返す。「多項式と出力環が共に exact なら出力は常に正しい（さもなくば例外）」。[S-C11]
- Sage は整係数多項式の複素根を**証明つきで孤立**する：無平方分解 → 数値的に根を見つけ → **区間演算で検証**し、各区間にちょうど 1 根を保証。実根の孤立も Descartes 符号則＋区間で certified。[S-C13][S-C14]
- 対比：`.roots(CC)`/`.roots(RR)`/`.roots(RDF)` は近似で、悪条件だと「相異なる根が重根に、重根が相異なる根に、実根が消失」しうる。[S-C12]
- **応用**：[統計力学 05](../対数順序群上の統計力学/05_相転移はΦで論じられるか.md) (a) の「有限 $N$ の代数的零点列が正実軸へ詰め寄る」という可算な量化言明 $\forall\epsilon\in\mathbb{Q}_{>0}\,\exists N\,\exists x_\ast:\mathrm{dist}(x_\ast,\mathbb{R}_{>0})<\epsilon$ は、各 $N$ で零点を `QQbar` に取り、正実軸への距離を `AA` で厳密比較することで、**浮動小数点の不確かさなしに**判定できる。[S-C15]

## 5. 浮動小数点に落ちる境界（脱出 (b) と一致）

- `QQbar`/`AA` → `RR`/`CC`/`RDF`/`CDF` の変換は有限精度の近似で、代数的数表現を離れた瞬間に厳密性を失う。[S-C16]
- `numerical_integral` は本質的に非厳密：GSL を呼び「答えと誤差推定のタプル」を返す（`eps_abs`/`eps_rel` で制御）。[S-C17]
- したがって **Onsager 型の連続積分**（熱力学極限の自由エネルギー密度、[統計力学 09](../対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md) Step 4）が、Sage が厳密・代数領域を離れる**唯一の典型箇所**。これは統計力学ノートの脱出 (b) $N\to\infty$ そのもの。有限サイズの量はすべて §1–4 のとおり厳密。[S-C18]

## 6. まとめ

| 計算対象 | Sage での扱い | 厳密性 |
|---|---|---|
| $Z_L(x)\in\mathbb{Z}[x]$、係数 $\Omega_L(m)$ | `ZZ['x']` | 誤差ゼロ [S-C1] |
| $\Phi_L=\log Z_L(q)$ | `factor()`→指数ベクトル | 誤差ゼロ [S-C9] |
| 零点（Fisher/Lee–Yang） | `.roots(QQbar/AA)` | 証明つき孤立 [S-C11,C13,C14] |
| 零点の符号・正実軸への距離 | `QQbar`/`AA` 比較 | 決定可能・certified [S-C5,C15] |
| 臨界点 $x_c=\sqrt2-1$ | `AA`（$u^2+2u-1=0$ の正根） | 厳密 [S-C3] |
| 自由エネルギー密度の積分 | `numerical_integral` | **非厳密**＋誤差推定 [S-C17] |

一文：**有限格子の統計力学量はすべて `ZZ`/`QQ`/`QQbar`/`AA` と素因数分解・certified 根孤立で誤差ゼロ・決定可能に厳密検証でき、浮動小数点に落ちるのは連続極限（Onsager 積分）だけ。** 形式証明側の「核は決定可能、脱出だけ `noncomputable`」（[01](01_自動証明_LeanCoq.md)）と完全に平行な構図。

（出典コード [S-*]=SageMath、[D-*]=決定可能性、は [出典.md](出典.md) に対応。）
