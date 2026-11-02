# SageMath Check: sine_zero

## 対象

**対象ラベル**: `sine_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sine_zero`（sin 0 = 0）
- 範囲: 背理法の二つの鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張 sin 0 = 0 | `check_proof_lines.sage` | AA（e^{i·0} の虚部）で厳密に | **PASS** | 成り立つ |
| 二つの鎖の各行（def_arcsin の第二の式・符号の整理） | `check_proof_lines.sage` | y₀ = ±k/20（k = 1..20）で、def_arcsin の第二の式の両辺（arcsin(y') と -arcsin(-y')）を Arb の arcsin のボールで比べる | **PASS** | 成り立つ |
| 矛盾の段（y₀ ≠ 0 なら arcsin(y₀) ≠ 0、-y₀ < y₀ なら arcsin(-y₀) < arcsin(y₀)） | `check_proof_lines.sage` | 同じ点でボールの比較で | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 主張 sin 0 = 0 を `AA`（e^{i·0} の虚部。共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: arcsin の値の比較だけ。本文の arcsin（弧の長さ）が標準の arcsin に等しいことは `arcsin_is_bijection` の検算で確かめてある。

範囲外のもの:

- 具体の点以外の y₀。arcsin の狭義単調増加そのもの（`arcsin_is_bijection` の検算が扱う）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_zero
```

実行ログは `logs/` に保存する。
