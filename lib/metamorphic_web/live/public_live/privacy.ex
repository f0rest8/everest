defmodule MetamorphicWeb.PublicLive.Privacy do
  @moduledoc false
  use MetamorphicWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white py-24 sm:py-32">
      <div class="mx-auto max-w-7xl px-6 lg:px-8">
        <div class="mx-auto max-w-2xl space-y-16 divide-y divide-gray-100 lg:mx-0 lg:max-w-none">
          <div class="grid grid-cols-1 gap-x-8 gap-y-10">
            <div>
              <h2 class="text-3xl font-bold tracking-tight text-zinc-900">Privacy</h2>
              <p class="mt-4 leading-7 text-zinc-600">Privacy is the standard on Metamorphic.</p>
            </div>
            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:col-span-2 lg:gap-8">
              <span class="group">
                <div class="group-hover:bg-brand-50 sm:group-hover:scale-105 transition rounded-2xl bg-gray-50 p-10">
                  <h3 class=" text-base font-semibold leading-7 text-brand-600 inline-flex items-center align-middle">
                    <.icon
                      name="hero-lock-closed-solid"
                      class="h-5 w-5 mr-1 inline-flex items-center align-middle"
                    /> Asymmetric
                  </h3>
                  <dl class="mt-3 space-y-1 text-sm leading-6 text-zinc-600">
                    <div class="mt-1">
                      <p>
                        Your data is encrypted to your account password so that only you can access it.
                      </p>
                    </div>
                  </dl>
                </div>
              </span>
              <span class="group">
                <div class="group-hover:bg-brand-50 sm:group-hover:scale-105 transition rounded-2xl bg-gray-50 p-10">
                  <h3 class=" text-base font-semibold leading-7 text-brand-600">
                    <.icon name="hero-banknotes-solid" class="h-5 w-5 mr-1 inline-flex items-center" />
                    Ownership
                  </h3>
                  <dl class="mt-3 space-y-1 text-sm leading-6 text-zinc-600">
                    <div class="mt-1">
                      <p>
                        You own your data and can delete your account, and all of its data, at any time.
                      </p>
                    </div>
                  </dl>
                </div>
              </span>
              <span class="group">
                <div class="group-hover:bg-brand-50 sm:group-hover:scale-105 transition rounded-2xl bg-gray-50 p-10">
                  <h3 class=" text-base font-semibold leading-7 text-brand-600">
                    <.icon name="hero-beaker-solid" class="h-5 w-5 inline-flex items-center" />
                    Guinea Pig Free
                  </h3>
                  <dl class="mt-3 space-y-1 text-sm leading-6 text-zinc-600">
                    <div class="mt-1">
                      <p>
                        We adore our furry friends, but you won't find any here. No user experiments ever.
                      </p>
                    </div>
                  </dl>
                </div>
              </span>
              <span class="group">
                <div class="group-hover:bg-brand-50 sm:group-hover:scale-105 transition rounded-2xl bg-gray-50 p-10">
                  <h3 class=" text-base font-semibold leading-7 text-brand-600">
                    <.icon name="hero-finger-print-solid" class="h-5 w-5 inline-flex items-center" />
                    Autonomy
                  </h3>
                  <dl class="mt-3 space-y-1 text-sm leading-6 text-zinc-600">
                    <div class="mt-1">
                      <p>
                        Connect and share free from fingerprints, spyware and trackers.
                      </p>
                    </div>
                  </dl>
                </div>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Privacy Policy -->
    <div id="privacy_policy" class="relative py-20">
      <div class="relative px-4 sm:px-6 lg:px-8 pb-20">
        <div class="flex-col p-8 mx-auto bg-zinc-50 space-y-4 rounded-lg shadow-lg shadow-brand-500/50 border border-brand-600">
          <div class="text-lg mx-auto">
            <h1>
              <span class="block text-base text-center text-brand-600 font-semibold tracking-wide uppercase">
                Privacy policy
              </span>
              <span class="mt-2 block text-3xl text-center leading-8 font-extrabold tracking-tight text-zinc-900  sm:text-4xl">
                November 9, 2021
              </span>
            </h1>
            <p class="mt-8 text-xl text-zinc-500  leading-8">
              We do not log or share personal information. That is our privacy policy in a nutshell. The rest of this policy tries to explain what information we may have, why we have it, how we protect it, and why you should care.
            </p>
          </div>
          <div class="space-y-4 mt-6 text-zinc-500  mx-auto">
            <p>
              Privacy is <strong>essential to a free life</strong>. Renowned author and CEW Professor Emerita at Harvard Business School, Shoshana Zuboff, dedicated 12 years to unmasking and naming the "emergence of a fundamentally anti-democratic economic logic" that she calls <.link
                navigate="https://shoshanazuboff.com/book/about/"
                target="_blank"
                rel="_noopener"
                class="text-brand-600 "
              >surveillance capitalism</.link>. Thanks to her we now have a framework around which to guide our efforts at preserving a more human future.
            </p>
            <p>
              The recent
              <.link
                navigate="https://bookshop.org/a/14891/9781984854636"
                target="_blank"
                rel="_noopener"
                class="text-brand-600 "
              >
                book
              </.link>
              from Cambridge Analytica whistleblower Christopher Wylie, reveals how the systems of surveillance capitalism are being weaponized against an unsuspecting public. It is a disturbing and insidious reality, where individuals and entire societies are living laboratory experiments, and the results of those experiments are the denigration of our ability to act, think, and believe for ourselves.
            </p>
            <p>
              Metamorphic is an alternative destination for social connection online, free of surveillance capitalism and psychometric profiling:
            </p>
            <ul class="space-y-1.5">
              <div>
                <.icon name="hero-check-badge" class="text-brand-600  mr-2 h-5 w-5 inline-flex" />You own 100% of your data
              </div>
              <div>
                <.icon name="hero-check-badge" class="text-brand-600  mr-2 h-5 w-5 inline-flex" />Your data is encrypted
              </div>
              <div>
                <.icon name="hero-check-badge" class="text-brand-600  mr-2 h-5 w-5 inline-flex" />You are
                <strong class="">not</strong>
                a guinea pig
              </div>
              <div>
                <.icon name="hero-check-badge" class="text-brand-600  mr-2 h-5 w-5 inline-flex" />Your data is
                <strong class="">not</strong>
                shared
              </div>
              <div>
                <.icon name="hero-check-badge" class="text-brand-600  mr-2 h-5 w-5 inline-flex" />You are
                <strong class="">not</strong>
                tracked
              </div>
            </ul>
            <p>
              Metamorphic is designed so that you can connect and share with the people in your life, on your terms. At Metamorphic, being human doesn't come at the expense of your humanity.
            </p>
            <p>
              When you create an account at Metamorphic, you can rest assured that what you see is what you get. We take this responsibility seriously.
            </p>

            <h2 class="font-bold">What is your data?</h2>
            <p>Your data on Metamorphic is information specific to your account.</p>
            <p>
              This information includes sign up or registration information: name, pseudonym, email, and password (irreversibly hashed).
            </p>
            <p>
              This information may also include data from: Connections and Posts.
            </p>
            <p>
              When we add new features to Metamorphic, then your list of data may expand to include any new features you use.
            </p>
            <p>
              <span class="font-bold text-zinc-900 ">
                It is important to know that you may delete any or all of your data at any time from within your account.
              </span>
            </p>

            <h2 class="font-bold">Where is your data stored?</h2>
            <p>
              Your <em>object data</em>
              (think avatars) is stored on a decentralized cloud network by <.link
                navigate="https://www.storj.io"
                target="_blank"
                rel="_noopener"
                class="text-brand-600 "
              >Storj</.link>. It is asymmetrically encrypted to your password-derived key and then encrypted again at rest with Storj's AES 256-bit symmetric encryption. Each file is then split into 80 pieces and stored on different nodes — all with different operators, power supplies, networks, and geographies. This decentralization adds another layer of protection and redundancy to your data (<.link
                navigate="https://www.storj.io/how-it-works"
                target="_blank"
                rel="_noopener"
                class="text-brand-600 "
              >only 29 pieces are required to re-build the encrypted file</.link>).
            </p>
            <p>
              Your <em>non-object data</em>
              (think text, messages, email, name, etc.) is currently stored on databases managed by our hosting provider, <.link
                navigate="https://render.com"
                target="_blank"
                rel="_noopener"
                class="text-brand-600 "
              >Render</.link>. This data is also asymmetrically encrypted (your email is also hashed as well for look-up functionality), then symmetrically encrypted by our server, before being stored in the database. Once at rest, Render additionally encrypts the database with their own symmetric encryption.
            </p>
            <p>
              By asymmetrically encrypting your data before it is uploaded, we ensure that your data remains private and protected.
            </p>
            <p>
              Your <span class="text-zinc-900 "><em>non-personal data</em></span>
              (like when your account was confirmed) is symmetrically encrypted by us and stored with your non-object data. It is not asymmetrically encrypted because it doesn't reveal anything to us about your account accept that it was confirmed, which is used for the functioning of the service.
            </p>
            <p>
              The only data not explicitly encrypted by our servers, but still encrypted at rest in the database by our storage providers, is boolean data that does not reveal your identity nor provide any meaningful information outside the functioning of the service.
            </p>
            <p>
              <span class="font-bold text-zinc-900 ">
                It is important to know that your data is asymmetrically encrypted before it is uploaded to any cloud storage locations, is only decryptable by you (the person who knows your password), and is deleted from the cloud location when you delete the file on your end. Data that is not asymmetrically encrypted nor simple boolean data (true/false), is still encrypted with strong symmetric encryption and would be protected against data breaches.
              </span>
            </p>

            <h2 class="font-bold">
              You own 100% of your data. <span class="opacity-25 line-through">data harvesting</span>
            </h2>
            <p>
              This means that you are in full control of your account information on Metamorphic and can even delete your account, and all of its information, at any time from within your account settings.
            </p>
            <p>
              <span class="font-bold text-zinc-900 ">
                There are only a few times when you are not in control of your account information: (a) if you are in violation of our <.link
                  class="text-brand-600 "
                  navigate="/terms"
                >terms of use</.link>, (b) if our company were to go out of business and all accounts were thus deleted, or (c) in compliance with a court-ordered legal request.
              </span>
            </p>
            <p>
              In the case of (a), depending on the severity of the violation, we will contact you before taking an action against your account (such as deleting it and all of its information). In the case of (b), we will do our best to provide reasonable notice of our impending shutdown so that you can prepare for it. And in the case of (c), we don't have access to any meaningful data due to the in-app asymmetric encryption. It would look something like this: "pJL3R8c2uGKLqJ1NUOTjL7u0er..." And even then, we will do our best to defend that meaningless information to the fullest extent of the law.
            </p>
            <p>
              <span class="font-bold text-zinc-900 ">
                In all cases: we will never share, sell, or otherwise transfer your data, and/or personal information, to third parties (except for the
                <.link navigate="#privacy_policy_metadata" class="text-brand-600 ">
                  metadata
                </.link>
                required by Stripe to handle your account payments and a court-ordered legal request that we cannot successfully defend against).
              </span>
            </p>

            <h2 class="font-bold">
              Your data is encrypted. <span class="opacity-25 line-through">backdoors</span>
            </h2>
            <p>
              We use encryption algorithms that are recommended by leading security and cryptography experts like Matthew Green, Niels Ferguson, and Bruce Schneier.
            </p>
            <p>
              Your data is asymmetrically encrypted in-app by your password-derived key. This means that only you can ever decrypt your data (for sharing or for yourself). We then wrap that encryption in a second layer of symmetric encryption before sending it to the database for storage, and those encryption keys are stored separately and rotated periodically. In the event of a data breach, your data would still be protected by very strong encryption.
            </p>
            <p>
              Your account password, and any password used for securing your content, is protected with an industry leading hashing algorithm that makes it virtually impossible to ever know your password. You may see this concept being referred to as an "irreversible password hash".
            </p>
            <p>
              You can read more about the encryption we use and how we protect your account by visiting our <.link
                navigate="/security"
                class="text-brand-600 "
              >security policy</.link>.
            </p>

            <h2 class="font-bold">
              You are not a guinea pig. <span class="opacity-25 line-through">lab experiments</span>
            </h2>
            <p>
              We do not participate in the surveilling and profiling of our customers (or anyone). We do not create psychometric profiles on you (or anyone). We do not conduct "invisible" (just outside of your awareness) experiments on you (or anyone).
            </p>
            <p>
              When you are on Metamorphic, you are free of the living laboratory experiment that is being conducted on you, and everyone else, on other platforms without your awareness.
            </p>

            <h2 class="font-bold">
              Your data is not shared.
              <span class="opacity-25 line-through">behavior modification</span>
            </h2>
            <p>
              We do not share, sell, or otherwise transfer your data to anyone outside of our company ever. Your data is used only in the service of your account (support & troubleshooting), to address a
              <.link navigate="/terms" class="text-brand-600 ">
                terms of use
              </.link>
              violation, or to comply with a court-ordered legal request.
            </p>

            <h2 class="font-bold">
              Your are not tracked.
              <span class="opacity-25 line-through">surveillance capitalism</span>
            </h2>
            <p>
              We do not use cookies or
              <.link
                navigate="https://spreadprivacy.com/browser-fingerprinting/"
                class="text-brand-600 "
                target="_blank"
                rel="_noopener"
              >
                fingerprinting
              </.link>
              to track or identify you. You can read our blog about our use of <.link
                navigate="/blog/clean-cookies"
                class="text-brand-600 "
              >clean cookies</.link>.
            </p>

            <div id="privacy_policy_metadata"></div>
            <h2 class="font-bold">Metadata</h2>
            <p>
              To the best of our knowledge, the extent of the possible information that could leak about your account (metadata) is all related to paying for your account. And in this regard, the information provided is your email address, name, card information, and device IP address.
            </p>
            <p>
              This information is handled and stored by Stripe, an industry leader in payments and security. The only information kept in our database is related to the Stripe payment plans we offer, Stripe products, a Stripe ID for the customer and subscription to synchronize with Stripe (symmetrically encrypted at rest and deterministically hashed for lookups on our end), and subscription information (like dates and status).
              <strong class="">
                This metadata does not provide access to your Metamorphic account nor its content, though it may be used to leak metadata about your account.
              </strong>
            </p>
            <h4 class="underline inline-flex">Why Stripe?</h4>
            <span class="inline-flex items-center rounded-full bg-pink-100 px-2 py-1 text-xs font-medium text-pink-700">
              Future
            </span>
            <div class="border-l-4 border-pink-400 bg-pink-50 p-4">
              <div class="flex">
                <div class="flex-shrink-0">
                  <.icon name="hero-information-circle-solid" class="h-5 w-5 text-pink-400" />
                </div>
                <div class="ml-3">
                  <p class="text-sm text-pink-700">
                    Metamorphic is currently free.
                    <a href="#" class="font-medium text-pink-700 underline hover:text-pink-600">
                      We are considering subscriptions for the future.
                    </a>
                  </p>
                </div>
              </div>
            </div>
            <p>
              We have chosen
              <a href="https://stripe.com" class="text-brand-600 " target="_blank" rel="_noopener">
                Stripe
              </a>
              as our current payment provider due to their world-class security, great <a
                class="text-brand-600 "
                href="https://stripe.com/climate"
                target="_blank"
                rel="_noopener"
              >climate initiative</a>, and strong <a
                class="text-brand-600 "
                href="https://stripe.com/privacy"
                target="_blank"
                rel="_noopener"
              >data policies</a>.
            </p>
            <p>
              Stripe maintains industry leading security of your payment information, we do not process or store your payment information. And this goes without saying: we do not share, rent, sell, or otherwise transfer your payment information to anyone ever. It is only and always handled by Stripe.
            </p>
            <h4 class="underline ">Ways to minimize metadata</h4>
            <p>
              It's important to understand what information might be able to be gleamed about your Metamorphic account through this Stripe metadata:
            </p>
            <ol>
              <li>
                <p>
                  It may be possible, with legal court orders, to sift through our database records, in conjunction with Stripe's, and determine who you are and who you are connected to on Metamorphic. This may be able to be done by linking the Stripe IDs with the customer on Stripe's end with the Stripe IDs on our end, and then linking the account IDs in corresponding relationships (or similarly using the subscription dates). When combined with the payment information that Stripe may have about you, and/or your credit card company, this method could be used to identify who you are, who you are connected to, and who you are communicating with on Metamorphic.
                </p>
                <p class="px-4">
                  <strong class="">
                    This can be minimized by using an anonymous email address for your Metamorphic account, although you will still have to enter a payment card which could be used to identify you.
                  </strong>
                </p>
              </li>
              <li>
                <p>
                  When you pay to use Metamorphic, you must input a payment card to be processed via Stripe. Upon doing so, Stripe will receive the email associated with your Metamorphic account (decrypted by your current session). They will also receive the name you input when you enter your payment, card details, and device IP address.
                </p>
                <p>This information is used by Stripe for risk assessment and fraud prevention.</p>
                <p class="px-4">
                  <strong class="">
                    To further mitigate identification from your device IP address that is sent to Stripe, you can use the
                    <a
                      class="text-brand-600 "
                      href="https://www.torproject.org/"
                      target="_blank"
                      rel="_noopener"
                    >
                      Tor
                    </a>
                    browser or a trusted VPN (or both).
                  </strong>
                </p>
                <p class="px-4">
                  We cannot offer any guidance on protecting your privacy from the transaction of your payment card, and for this reason alone,
                  <strong class="">
                    if you are a high-risk person without the relevant expertise, then we recommend you not use our service at this time.
                  </strong>
                </p>
              </li>
            </ol>
            <p>
              While it is very difficult to minimize metadata, the metadata that can be gleamed from your Stripe payment (with the proper court orders) does not change the fact that only you can access the contents of your account.
            </p>
            <p>
              Again, it is important to remember that none of this metadata can give someone access to your account or provide them with the actual information in your account.
            </p>
            <p>
              Similar to a service like Signal, a legal government court order could enable a government entity to determine (1) who you are, (2) who you are connected to, and (3) who you may be in communication with — but it cannot reveal the contents of your communication, nor can your life be harvested for the benefit of surveillance capitalists.
            </p>

            <h2 class="font-bold">Other</h2>
            <p>
              Check out
              <a
                class="text-brand-600 "
                href="https://clickclickclick.click/"
                target="_blank"
                rel="_noopener"
              >
                ClickClickClick
              </a>
              to see what creepy things can happen to you on other websites.
            </p>
            <p>
              Are you a business or startup that needs analytics?
              <a
                class="text-brand-600 "
                href="https://usefathom.com/ref/CGEXGD"
                target="_blank"
                rel="_noopener"
              >
                Fathom Analytics
              </a>
              is a trusted privacy-focused solution for businesses of all sizes.
            </p>
            <p>This policy is heavily influenced by Gabriel Weinberg's for DuckDuckGo — thank you.</p>

            <h2 class="font-bold">Updates</h2>
            <p>
              If this policy is substantively updated, we will update the text of this page and provide notice to you by writing '(Updated)' in rose next to the link to this page (in the footer) for a period of at least 30 days.
            </p>
            <p>
              We will also mention the update to our terms, and potentially discuss in more detail, on the latest epside of our
              <a
                class="text-brand-600 "
                href="https://podcast.metamorphic.app"
                target="_blank"
                rel="noopener"
              >
                podcast
              </a>
              to air after the update.
            </p>

            <h2 class="font-bold">Feedback</h2>
            <p>
              I (Mark Thayer) am the creator of Metamorphic, and personally wrote this privacy policy. If you have any questions or concerns, please <a
                class="text-brand-600 "
                href="mailto:support@metamorphic.app"
              >send feedback</a>.
            </p>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
