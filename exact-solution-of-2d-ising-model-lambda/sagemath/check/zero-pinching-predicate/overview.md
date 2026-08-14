# SageMath Check: 詰め寄りの述語の定式化

## 対象

**対象ラベル**: `def_zero_pinching_predicate`, `claim_distance_positive_on_fisher_zeros`,
`def_phase_transition_countable_statement`

- 実行日: 2026-08-14
- 結果: 有限標本検査がすべて通過
- 帰属: `QQ`・`AA`・`QQbar` の厳密計算。浮動小数点を使わない。

## 何を確かめるか

モデル $R=\texttt{AA}$（Sage の実代数的数体）、$\omega=\texttt{QQbar(I)}$ で、
本文の 3 ブロックに対応する計算を有限標本で確かめる。普遍量化された主張そのものの
証明は本文の人手証明が担い、この検査だけからは導かない。Lean 具体版・必要十分版・導出も完成している。

- 述語の決定可能性（`def_zero_pinching_predicate`）: $L\in\{1,2\}$ の全 Fisher 零点 ×
  正の有理点 $q$ 6 点 × $\varepsilon$ 5 点の 240 件で、両辺
  $\mathrm{dsq}(\xi,q)$ と $\varepsilon\cdot\varepsilon$ が `AA` の元であり、
  厳密比較 $<$（`AA` では「差が零元でない平方」と狭義の正が同値）で真偽が
  決定できること
- 距離の二乗の非零性（`claim_distance_positive_on_fisher_zeros`）: 同じ零点 × $q$ の
  48 組すべてで $\mathrm{dsq}(\xi,q)\ne0$ であること
- 言明の各 $\varepsilon$ 段のモデル検査（`def_phase_transition_countable_statement`）:
  $\varepsilon$ 5 点それぞれについて、標本の範囲に $\mathrm{dsq}(\xi,q)<_{R}
  \varepsilon\cdot\varepsilon$ の証人があるかを記録する（$\varepsilon=1/2,1,2$ は
  $L=2$ に証人あり。$\varepsilon=1/10,1/4$ はこの標本の範囲では証人なし。
  **証人が無いことは失敗ではない**。言明の証明は本文の今後のセクションが担う）

## 範囲の注記（黙って狭めない）

$L=3$ の Fisher 零点は最小多項式の次数が 12 で、`real()`/`imag()` と `AA` の
厳密比較の exactify が資源上限で終わらない（`real-closed-subfield` の検査と同じ理由）。
$L\in\{1,2\}$ に限る（$L=1$ は零点なし、$L=2$ は次数 8 の零点 8 個）。
検査の内容自体は緩めていない。`AA`・`QQbar` の等号・順序比較は厳密であり、
数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
