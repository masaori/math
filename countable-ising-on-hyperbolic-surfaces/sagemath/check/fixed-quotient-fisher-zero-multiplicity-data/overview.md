# 固定剰余類格子の Fisher 零点の代数的重複度データ

**対象ラベル**: `theorem_fixed_quotient_fisher_zero_multiplicity_data`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_zero_multiplicity_data`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の分配多項式について、`QQbar` に属する Fisher 零点の台と重複度

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_multiplicity_data.sage` | 既約分解を復元し、次数 `44` の因子の根を `QQbar` で厳密構成して相異なる単根が `44` 個であること、`-1` の重複度が `12` であることを照合する | PASS | 相異なる Fisher 零点は `45` 個、重複度の総和は `56` |

## 備考

- 根は `QQbar` の厳密な代数的数として構成し、浮動小数点近似へ変換しない。
- 複素平面への埋め込み、距離、偏角、数値描画、極限、積分を用いない。
- 各根を個別に識別する根分離データは次の作業で扱う。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-zero-multiplicity-data/check_multiplicity_data.sage
```
