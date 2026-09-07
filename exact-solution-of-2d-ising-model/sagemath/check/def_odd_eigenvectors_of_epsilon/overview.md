# SageMath Check: def_odd_eigenvectors_of_epsilon

## 対象

**対象ラベル**: `def_odd_eigenvectors_of_epsilon` （structured-latex 側の安定識別子）

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
bash sagemath/tools/run-all-checks.sh def_odd_eigenvectors_of_epsilon
```

実行ログは `sagemath/check/def_odd_eigenvectors_of_epsilon/logs/` に保存する。
