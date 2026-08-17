# 固定剰余類格子の Fisher 零点の有理矩形根分離証明書

**対象ラベル**: `theorem_fixed_quotient_fisher_zero_rational_rectangle_isolation`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_zero_rational_rectangle_isolation`）
- 範囲: 固定した剰余類格子の分配多項式に現れる次数 `44` の既約因子について、全ての根を区別する有理矩形根分離証明書

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_root_isolation_data.sage` | 二十二個の上半平面有理矩形と共役矩形が互いに交わらず、各矩形が `Q_Q` の単根を一つだけ含み、四十四個の矩形が全ての根を重複なく覆うことを認証付き複素根分離と `QQbar` の厳密等号で照合する | PASS | 有理矩形四十四個と代数的根四十四個が一対一に対応し、共役対二十二組をなす |

## 備考

- 矩形の端点は全て有理数であり、外向き区間演算による包含判定も有理数の比較へ戻している。
- `QQbar.polynomial_root` は整数係数多項式と根を一つだけ含む認証済み区間から代数的数を構成する。浮動小数点近似値を同一性判定や根のラベルとして使わない。
- 複素平面への数値描画、距離、偏角、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-zero-root-isolation-data/check_root_isolation_data.sage
```
