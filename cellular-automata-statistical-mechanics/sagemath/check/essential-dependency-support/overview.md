# SageMath 検算: 本質的依存台の有限決定

## 対象

**対象ラベル**: `claim_support_finite_decidability`

- 併せて検証: `claim_flip_test_equivalence`
- 検証範囲: 2 元集合での異なる値の一意性、本質的依存と一点反転検査の同値、一点反転走査による依存台と比較回数上界
- 全数範囲: $|S|=0,1,2,3$ の全真理値表。$|S|=3$ では初等 CA と同じ入力数を持つ 256 規則を全て含む

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_unique_binary_alternative.sage` | $A=\{0,1\}$ で $a$ と異なる元が $\nu(a)$ だけであり、$\nu$ が対合である | PASS | 2 元を厳密検査 |
| `check_flip_test_equivalence.sage` | 本質的依存の存在量化と一点反転検査が一致する | PASS | $|S|\le3$ の全 278 真理値表で一致 |
| `check_support_scan_bound.sage` | 走査結果が本質的依存台と一致し、比較回数が $|S|2^{|S|}$ 以下である | PASS | $|S|\le3$ の全 278 真理値表で一致。最大比較回数は各上界に一致 |

## 限界と帰属

- 全数検査は $|S|\le 3$ に限られ、一般の有限集合に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- すべて有限集合、自然数の回数、2 元集合の等号として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/essential-dependency-support/check_*.sage; do sage "$file"; done
```
