# SageMath Check: def_even_eigenvectors_of_epsilon

## 対象

**対象ラベル**: `def_even_eigenvectors_of_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `F^{(+)}={f∈C^{2^M} | εf=f}` という具体的な行列作用による定義

## チェック一覧

| ファイル | 検査内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_even_eigenvectors.sage` | 全成分が `1` の固定ベクトルについて定義式 `εf=f` を数値校正する | 5 | 0.000e+00 | **PASS** |

この検査は `M=1,2,3,4,5` の有限例について、選んだ全成分 `1` の固定ベクトルが
`F^{(+)}` の定義条件 `εf=f` を満たすことだけを数値校正する。固有値 `-1` の定義、
部分空間性、次元公式、一般の `M` に対する証明は対象に含めない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_even_eigenvectors_of_epsilon
```

実行ログは `sagemath/check/def_even_eigenvectors_of_epsilon/logs/` に保存する。
