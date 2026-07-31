# 対数順序群の機械検証性（形式証明・厳密数値計算における効用）

[対数順序群上の統計力学](../対数順序群上の統計力学/README.md) の立場 ──「核は可算な対数順序群 $\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ で閉じ、$\mathbb{R}/\mathbb{C}$ への脱出は不可欠な箇所（指数評価・$N\to\infty$・微分）に限る」── を、**機械検証の工学**の側から正当化するノート群。

問いは一つ：**議論を $\Lambda$（および $\mathbb{Z},\mathbb{Q},\mathbb{Z}[x],\overline{\mathbb{Q}}$）に絞ると、(1) Lean/Coq/Isabelle による形式証明と、(2) SageMath による厳密数値計算が、具体的にどれだけ楽になるのか。** 答えを根拠（一次資料）つきで整理する。

## 結論（二つの工学的メリット）

1. **形式証明（Lean/Coq）**：$\Lambda$ 上の主張は等号・順序が**決定可能（decidable）**な対象だけで書けるので、`omega`/`lia`/`decide` で**自動放電**できる。実数 $\mathbb{R}$ を持ち込むと等号は構成的に決定不能・順序は半決定のみとなり、`noncomputable` と解析ライブラリの重量級証明に飲まれる。$\ell_p$ を**形式生成元**として扱えば $\log p$ の超越性証明すら不要。
2. **厳密数値計算（SageMath）**：$\mathbb{Z}[x]$ の係数・素因数分解・$\overline{\mathbb{Q}}$ の零点はすべて `ZZ`/`QQ`/`QQbar`/`AA` で**誤差ゼロ・決定可能**に計算でき、零点の正実軸への詰め寄りや符号も区間演算で**証明つき**で判定できる。浮動小数点 (`RR`/`RDF`) に落ちるのは連続極限（Onsager 積分）だけで、それは [統計力学ノート](../対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md) の脱出 (b) と完全に一致する。

一文：**「$\Lambda$ に絞る」＝「決定可能・厳密計算可能な世界に絞る」であり、形式証明では自動化が効き、厳密計算では誤差が出ない。$\mathbb{R}$ への脱出箇所が、そのまま形式証明の `noncomputable` 化点・厳密計算の浮動小数点化点に一致する。**

## ファイル一覧

- [00_問いと前提.md](00_問いと前提.md) — 何を主張するか。$\Lambda$ の復習と「decidable／computable な対象に絞る」という再解釈。統計力学ノートの脱出 (a)(b)(c) と機械検証の劣化点の対応表。
- [01_自動証明_LeanCoq.md](01_自動証明_LeanCoq.md) — Lean/Coq/Isabelle 側のメリット。実数の形式化コスト、決定可能性 (Presburger/⊕ℤ vs RCF vs 解析)、Mathlib の整備状況（`Finsupp`/`Nat.factorization`）、超越性回避、差分商の軽さ。
- [02_厳密計算_SageMath.md](02_厳密計算_SageMath.md) — SageMath 側のメリット。`QQbar`/`AA` の厳密性と決定可能な比較、素因数分解＝$\log$、$\mathbb{Z}[x]$ 零点の厳密化、浮動小数点に落ちる境界（数値積分）。
- [03_横断原理.md](03_横断原理.md) — 「可算・離散・代数的は検証に優しく、実数・連続・極限はコストが跳ねる」の一般的裏付け（計算可能解析 TTE・逆数学）。統計力学・Ising 形式化の先行研究は**空白**（新規性の余地）。
- [出典.md](出典.md) — 全主張の一次資料 URL と確信度。

## 早見表：$\Lambda$ 内 vs $\mathbb{R}$ 脱出後

| 観点 | $\Lambda$／可算・代数的（核） | $\mathbb{R}$／連続（脱出後） |
|---|---|---|
| 対象 | $\mathbb{N},\mathbb{Q},\Lambda=\bigoplus_p\mathbb{Z}\ell_p,\mathbb{Z}[x],\overline{\mathbb{Q}}$ | $\mathbb{R},\mathbb{C}$、極限・積分・$\exp$ |
| 等号判定 | 決定可能（整数比較に還元） | 構成的に**決定不能** |
| 順序判定 | 決定可能（$N_+>N_-$） | **半決定**のみ（$x\ne y$ なら有限時間、$x=y$ で停止せず） |
| Lean/Coq 自動化 | `omega`/`lia`/`decide` で放電 | 専用の重い解析証明、`noncomputable` |
| 必要な公理 | RCA$_0$ 級（計算可能数学） | WKL$_0$/ACA$_0$ 以上（解析の公理コスト） |
| SageMath | `ZZ`/`QQ`/`QQbar`/`AA` で誤差ゼロ・証明つき | `numerical_integral`→浮動小数点＋誤差推定 |
| 統計力学での所在 | 有限格子の $Z_L$・零点・$\Phi_L$・臨界点 $x_c=\sqrt2-1$ | 自由エネルギー密度（Onsager 積分）・非解析性 |

（注：「decidable」は文脈依存の罠語。Lean/古典 HOL では「LEM で `Decidable` インスタンスが在る」を指し、実数にも `noncomputable` な `DecidableEq ℝ` が在る。本ノートで言う決定可能は**アルゴリズムで判定できる**＝構成的・実行可能の意味。詳細は [01](01_自動証明_LeanCoq.md) §1。）
