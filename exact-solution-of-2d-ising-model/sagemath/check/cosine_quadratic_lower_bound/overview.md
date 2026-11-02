# SageMath Check: cosine_quadratic_lower_bound

## 対象

**対象ラベル**: `cosine_quadratic_lower_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosine_quadratic_lower_bound`（t ∈ [0, π/2] なら cos t - 1 + t²/2 ≥ 0）
- 範囲: t = 0 の場合と鎖の五行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| t = 0 の場合と 1 行目 | `check_proof_lines.sage` | AA で厳密に | **PASS** | 成り立つ |
| 導関数 G' = -sin u + u = u - sin u と 2・4 行目 | `check_proof_lines.sage` | SR の記号微分・記号積分（t > 0 を仮定） | **PASS** | 成り立つ |
| 3 行目の被積分関数の符号 u - sin u ≥ 0 | `check_proof_lines.sage` | [0, π/2] の 12 等分点で sin を AA、u = qπ をボールで | **PASS** | 成り立つ |
| 鎖の両端と主張 | `check_proof_lines.sage` | 同じ点で cos を AA、t をボールで | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | 逆向きの狭義の不等号がボールで確定する: t²/2 を落とすと t = π/4 で成り立たない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: sin・cos の値は、角度を π の有理数倍に限り、1 の冪根の虚部と、本文の定義 cos θ := √(1 - (sin θ)²) から `AA` で作る（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。等号の行は `QQ` 上の多項式環・`AA` で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: 角度 `qπ` と π を含む量の大小だけ。π が `QQ`・`AA` に入らないためである。Arb の `pi()` は π を厳密に含む区間で、判定は差のボールの下端の符号で行い、許容誤差は置かない。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4) そのもの。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosine_quadratic_lower_bound
```

実行ログは `logs/` に保存する。
