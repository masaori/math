# SageMath Check: def_odd_eigenvectors_of_epsilon（退避）

## 対象

退避対象ラベル: `def_odd_eigenvectors_of_epsilon`

**このブロックはもう本文ではない。** (−) セクターを本文から外したとき（2026-09-26）、
`structured-latex/content/004_transfer_matrix.ts` の定義ブロック `transfer_matrix_004_definition_eigenspace_odd_of_epsilon` は
参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` の
`note_transfer_matrix_004_definition_eigenspace_even_of_epsilon_minus_sector_transfer_matrix_004_definition_eigenspace_odd_of_epsilon`
（`targets: def_even_eigenvectors_of_epsilon`）へ内容のまま退避された。

ラベルは本文に実在しないので、`tools/verify-check-linkage.ts`（`check/` 配下だけを見る）の対象外である。

移動に伴い、共有ライブラリへの相対パスを `../../../_shared/operators.sage` に直し、2026-09-26 に移動先で再実行して PASS した。


- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `F^{(-)}={f∈C^{2^M} | εf=-f}` という具体的な行列作用による定義

## チェック一覧

| ファイル | 検査内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_odd_eigenvectors.sage` | 最初と最後の標準基底ベクトルの差について定義式 `εf=-f` を数値校正する | 5 | 0.000e+00 | **PASS** |

この検査は `M=1,2,3,4,5` の有限例について、選んだ二つの標準基底ベクトルの差が
`F^{(-)}` の定義条件 `εf=-f` を満たすことだけを数値校正する。部分空間性、次元公式、
一般の `M` に対する証明は対象に含めない。

## 実行方法

```bash
cd sagemath/_old/minus-sector/def_odd_eigenvectors_of_epsilon && sage check_odd_eigenvectors.sage
```

実行ログは `sagemath/_old/minus-sector/def_odd_eigenvectors_of_epsilon/logs/` に保存する。
