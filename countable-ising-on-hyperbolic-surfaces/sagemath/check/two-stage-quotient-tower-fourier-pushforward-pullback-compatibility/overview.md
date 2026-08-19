# 商の塔における有限 Fourier 変換と押し出し・引き戻しの整合性の検算

**対象ラベル**: `theorem_quotient_tower_fourier_pushforward_pullback_compatibility`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_fourier_pushforward_pullback_compatibility`）
- 範囲: 粗段 Fourier 成分から、押し出しファイバーの分割と文字引き戻しを経て細段 Fourier 成分へ至る四つの等式
- 併せて検証: `def_quotient_tower_homology_polynomial_family_pushforward_map`、`theorem_quotient_tower_integer_sign_character_evaluation_pullback_compatibility`、`theorem_finite_fourier_inverse_transform`

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_fourier_and_pushforward_definitions.sage` | 粗段 Fourier 成分を押し出しファイバーの二重和へ定義展開する | PASS | 粗段文字二つで一致 |
| `check_fiber_partition_reindexing.sage` | 全ファイバーによる有限添字集合の分割で二重和を細段類の一重和へ移す | PASS | 二元ファイバー二つで一致 |
| `check_sign_pullback_compatibility.sage` | 押し出し像での粗段整数符号を引き戻し文字の細段整数符号へ置換する | PASS | 粗段文字二つ・細段類四つで一致 |
| `check_fine_fourier_identification.sage` | 引き戻し文字による細段和を細段 Fourier 成分として同定する | PASS | 粗段文字二つで一致 |

## 備考

- 非自明な有限例として `H_fine = F_2^2`、`H_coarse = F_2`、押し出しを第一座標への射影とし、二元ファイバー二つと粗段文字二つを全列挙する。
- 多項式族の四成分を独立不定元として置くため、特定の係数値だけでなく任意の `ZZ[u,v]` 値族に対する恒等式を記号的に検算する。
- 浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- 初回実行では四ファイルとも、可変な SageMath ベクトルを辞書キーにしたため `TypeError: mutable vectors are unhashable` で ERROR となった。有限 `F_2` 元を不変タプルで表すよう修正し、再実行した四ファイルは全て PASS した。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fourier-pushforward-pullback-compatibility/check_*.sage; do
  sage "$f"
done
```
