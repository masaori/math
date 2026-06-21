# MEMORY（対数順序群の機械検証性）

## このフォルダの目的

[対数順序群上の統計力学](../対数順序群上の統計力学/README.md) の「核は $\Lambda$、脱出だけ $\mathbb{R}$」という立場を、**形式証明（Lean/Coq）と厳密数値計算（SageMath）の工学**の側から正当化する。中心命題：**数学的厳密性の境界（$\Lambda$ vs $\mathbb{R}$）＝形式証明の自動化/`noncomputable` 境界＝厳密計算の exact/浮動小数点境界＝計算可能性の RCA$_0$/WKL$_0$ 境界**、が全部同じ場所に引かれている。

## 確定済み（リサーチ済み・出典つき）

- 実数：Mathlib は Cauchy 完備化、Coq は公理的。等号は構成的に決定不能、順序は半決定のみ。`Real.decidableEq` は `noncomputable`。解析の形式化は重い。
- 決定可能性：Presburger $(\mathbb{Z},+,<)$ 決定可能、⊕ℤ＝ℤⁿ は整数比較で決定可能。RCF は決定可能だが二重指数。`omega`/`lia`/`decide` で核を自動放電。
- Mathlib：`Nat.Primes →₀ ℤ`（Finsupp）が最適キャリア、`Nat.factorization` が $\log$＝素因数分解として完備。超越性 (log p) は Isabelle AFP にあり、Mathlib 未パッケージ。**形式生成元扱いで超越性証明を完全回避**が鍵。
- SageMath：`QQbar`/`AA` で代数的数を厳密表現・certified 比較、`factor()`＝$\log$、`.roots(QQbar)` で零点厳密化。浮動小数点に落ちるのは `numerical_integral`（Onsager 積分）だけ。
- 先行研究：Ising/Onsager/Kac–Ward/Pfaffian の証明支援系形式化は**空白**（PhysLean に二準位カノニカルのみ）。determinant は Mathlib にあり。

## 次回やりうること

- 否定的所見（Ising 形式化の空白）の確度を上げる：Mathlib＋Isabelle AFP＋Coq opam の直接 grep。
- 具体実証：[統計力学 09](../対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md) Step 1 の $Z_{C_4}(x)=2+12x^2+2x^4$ を SageMath で `factor()`→$\Phi\in\Lambda$、零点 `QQbar` 化まで実際に走らせ、sagemath/ 配下に check として置く。
- Lean 側の最小 PoC：`Nat.Primes →₀ ℤ` で $\Lambda$ を定義し、第〇法則 $\beta_A=\beta_B$ を `omega`/`decide` で放電する小例。
- arXiv:2603.24823（Gelfond–Schneider/Lean、将来日付表記）のリンク健全性を確認し [出典.md](出典.md) を更新。

## 注意

- 「decidable」は罠語。Lean/古典 HOL の `Decidable`（LEM で存在）と、構成的・実行可能な決定可能性を区別する。本フォルダの主張は後者。
- 数式入り表は閲覧環境で崩れることがある。箇条書き主体に。
