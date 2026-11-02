# SageMath Check: scalar_multiple_of_zero_matrix

## 対象

**対象ラベル**: `scalar_multiple_of_zero_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_scalar_multiple_of_zero_matrix`
- 主張: `a ∈ ℂ` について `aO = O`（`O ∈ Mat(m,n,ℂ)`）
- 範囲: 証明の成分ごとの鎖の 4 行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 複素数を `definition_of_cc` の実数の組 `(p,q)` で持ち、鎖の 5 つの項を各行の式どおりに別々に組んで隣り合う項が等しいこと。全成分が一致すること。独立な経路として Sage の行列のスカラー倍でも確かめた。否定コントロール: 零でない行列のスカラー倍は零行列と一致しない | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。積は `definition_of_cc` の積を自前で組んだ。
- 帰属: `QQ` 上の多項式環。不定元で成り立つ多項式の等号は、`a` の実部・虚部へ任意の実数を代入しても成り立つ。
- 大きさは `m, n ∈ {1, 2, 3}` の 9 通りで、一般の大きさは人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh scalar_multiple_of_zero_matrix
```

実行ログは `logs/` に保存してある（2026-11-02）。
