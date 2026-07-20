import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:delivery_app_project/core/constants/app_assets.dart';
import 'package:delivery_app_project/core/theme/app_colors.dart';
import 'package:delivery_app_project/core/theme/text_styles.dart';
import 'package:delivery_app_project/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery_app_project/core/di/injection_container.dart' as di;
import 'package:delivery_app_project/features/profile/presentation/bloc/chat_cubit.dart';
import 'package:delivery_app_project/features/profile/presentation/bloc/chat_state.dart';
import 'package:delivery_app_project/core/widgets/app_directional_icons.dart';

class SupportScreen extends StatelessWidget {
  final String? ticketId;

  const SupportScreen({super.key, this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = di.sl<ChatCubit>();
        if (ticketId != null) {
          cubit.fetchMessages(ticketId!);
        }
        return cubit;
      },
      child: _SupportScreenContent(ticketId: ticketId),
    );
  }
}

class _SupportScreenContent extends StatefulWidget {
  final String? ticketId;

  const _SupportScreenContent({this.ticketId});

  @override
  State<_SupportScreenContent> createState() => _SupportScreenContentState();
}

class _SupportScreenContentState extends State<_SupportScreenContent> {
  static const _headerContentHeight = 68.0;
  static const _composerTopPadding = 16.0;
  static const _composerHorizontalPadding = 16.0;
  static const _composerBottomPadding = 16.0;
  static const _messageHorizontalPadding = 16.0;

  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  List<SupportChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Inject mock data exactly as shown in Figma
    _messages = [
      SupportChatMessage(
        id: '1',
        text: 'مساء الخير',
        isMine: false,
        createdAt: DateTime.now(),
      ),
      SupportChatMessage(
        id: '2',
        text: 'نقد نساعد حضرتك ازاي ؟',
        isMine: false,
        createdAt: DateTime.now(),
      ),
      SupportChatMessage(
        id: '3',
        text: 'المطعم اتاخر عليا في تسليم الطلب',
        isMine: true,
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    
    // Simulate adding message in UI
    setState(() {
      _messages.add(SupportChatMessage(
        id: DateTime.now().toString(),
        text: text,
        isMine: true,
        createdAt: DateTime.now(),
      ));
    });
    
    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground(context),
        body: Column(
          children: [
            _SupportChatHeader(title: l10n.supportChatTitle),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                reverse: false,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  _messageHorizontalPadding,
                  24,
                  _messageHorizontalPadding,
                  24,
                ),
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _DateSeparator(label: l10n.supportToday),
                    );
                  }
                  final message = _messages[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _FigmaChatBubble(message: message),
                  );
                },
              ),
            ),
            _SupportComposer(controller: _controller, onSend: _sendText),
          ],
        ),
      ),
    );
  }
}

class _FigmaChatBubble extends StatelessWidget {
  const _FigmaChatBubble({required this.message});

  final SupportChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Row(
      mainAxisAlignment: isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isMine)
          Flexible(
            child: _buildBubble(context, isMine),
          )
        else ...[
          Flexible(
            child: _buildBubble(context, isMine),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssets.supportAgentIcon,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBubble(BuildContext context, bool isMine) {
    return Column(
      crossAxisAlignment: isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMine ? const Color(0xFFF1F1F1) : const Color(0xFFFCEAEB),
            borderRadius: BorderRadiusDirectional.only(
              topStart: const Radius.circular(16),
              topEnd: const Radius.circular(16),
              bottomStart: isMine ? Radius.zero : const Radius.circular(16),
              bottomEnd: isMine ? const Radius.circular(16) : Radius.zero,
            ),
          ),
          child: Text(
            message.text,
            style: AppTextStyles.body(context).copyWith(
              color: AppColors.onSurface(context),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '02:20PM',
          style: AppTextStyles.caption(context).copyWith(
            color: AppColors.paragraph(context),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _SupportChatHeader extends StatelessWidget {
  const _SupportChatHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final topSafe = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: topSafe + _SupportScreenContentState._headerContentHeight,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: [
          Container(color: AppColors.primary),
          Positioned.fill(
            child: Image.asset(
              AppAssets.supportHeaderPattern,
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            start: 16,
            end: 16,
            top: topSafe,
            bottom: 20,
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => context.pop(),
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: Icon(
                        AppDirectionalIcons.backChevron(context),
                        color: AppColors.text,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.primaryButtonLabel.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateSeparator extends StatelessWidget {
  const _DateSeparator({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.caption(context).copyWith(
          color: AppColors.paragraph(context),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.3,
        ),
      ),
    );
  }
}

class _SupportComposer extends StatelessWidget {
  const _SupportComposer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(
        _SupportScreenContentState._composerHorizontalPadding,
        _SupportScreenContentState._composerTopPadding,
        _SupportScreenContentState._composerHorizontalPadding,
        bottomSafe + _SupportScreenContentState._composerBottomPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onSend,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border(context), width: 1.0),
              ),
              child: Image.asset(
                AppAssets.chatSentIcon,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border(context), width: 1.0),
              ),
              child: Image.asset(
                AppAssets.chatImageAddIcon,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.start,
                cursorColor: AppColors.cursor(context),
                minLines: 1,
                maxLines: 1,
                style: AppTextStyles.inputText(
                  context,
                ).copyWith(fontSize: 14, height: 1.3),
                decoration: InputDecoration(
                  hintText: 'اكتب هنا...',
                  hintStyle: AppTextStyles.inputHint(context).copyWith(
                    color: AppColors.paragraph(context),
                    fontSize: 12,
                    height: 1.3,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.scaffoldBackground(context),
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.border(context),
                      width: 0.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.border(context),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.fieldFocusBorder(context),
                      width: 0.5,
                    ),
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
