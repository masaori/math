# SageMath Check: matrix_sum_is_commutative

## 対象

**対象ラベル**: `matrix_sum_is_commutative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_sum_is_commutative`
- 主張: `A, B ∈ Mat(m,n,ℂ)` について `A + B = B + A`
- 範囲: 証明の成分ごとの鎖の 3 行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 複素数を `definition_of_cc` の実数の組 `(p,q)` で持ち、`A, B` の成分を不定元にして、鎖の 4 つの項を各行の式どおりに別々に組んで隣り合う項が等しいこと。全成分が一致すること。対照: 行列の積は一般に交換しない | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。和は `definition_of_cc` の和を自前で組んだ。
- 帰属: `QQ` 上の多項式環。大きさは `m, n ∈ {1, 2, 3}` の 9 通りで、一般の大きさは人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_sum_is_commutative
```

実行ログは `logs/` に保存してある（2026-11-02）。
