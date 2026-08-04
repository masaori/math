/**
 * **検査 L（見出し代わりの断片）の型と判定**。
 *
 * ## なぜこの検査が要るのか
 *
 * cycle 27 step 4b は、ユーザーの判断にしたがって本文から強調指定 2534 個を落とした。
 * そのとき**強調が唯一の区切りだった箇所**が、区切りを失った。
 *
 * 実例（cycle 28 step 3 で全数を読んで見つけた）: 命題 Q の「可算と非可算の分別」と、
 * 7 命題の「限界」。どれも直後の箇条書きを導く見出しとして書かれていたが、
 * 強調を落とすと**述語のない体言止めの段落**が本文に落ちているだけになる。
 * 読者には、前の段落の続きなのか次の箇条書きの一部なのか分からない。
 *
 * ## 何を見るか
 *
 * **箇条書きの直前にある、短くて文になっていない段落**を違反とする。判定は 3 つの積である。
 *
 * 1. 段落の直後が `list` であること。
 * 2. 段落の文字数が短いこと（`MAX_LENGTH`）。長い段落は文になっているとみなす。
 * 3. 文末が句点・コロン等で終わっていないこと。終わっていれば文として読める。
 *
 * ## 何を見ないか（範囲を正直に書く）
 *
 * - **数式を導く断片は対象外である。** 「したがって」「が成り立つ。ここで」のような、
 *   直後の別行立て数式へ続く言い回しは日本語として正しく、見出しではない。
 *   判定 1 が `list` に限っているのはこのためである。
 * - **「文になっているか」を機械で判定してはいない。** 見ているのは長さと文末の字だけである。
 *   体言止めでも長ければ通るし、短くても句点があれば通る。
 *   **この検査が捕まえるのは「見出しの代わりに置かれた短い断片」という形だけ**であって、
 *   読みやすさそのものではない。
 */

export type RunInLabelSite = {
  readonly locale: string;
  readonly blockId: string;
  readonly file: string;
  readonly where: "statement" | "proof";
  /** 段落を平たくした文字列（数式は 1 文字として数える）。 */
  readonly text: string;
  /** 直後のノードの種別。`list` のときだけ判定する。 */
  readonly nextType: string;
};

/** これより長い段落は文になっているとみなす。実測: 直った 8 件はいずれも 12 文字以下だった。 */
export const MAX_LENGTH = 46;

/** 文末として認める字。ここで終わっていれば文として読める。 */
const SENTENCE_ENDINGS = ["。", "：", ":", ".", "?", "!", "？", "！"];

export const isRunInLabel = (site: RunInLabelSite): boolean => {
  if (site.nextType !== "list") return false;
  const text = site.text.trim();
  if (text.length === 0 || text.length > MAX_LENGTH) return false;
  return !SENTENCE_ENDINGS.some((ending) => text.endsWith(ending));
};
