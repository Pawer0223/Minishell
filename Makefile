NAME	= minishell

# -I/opt/homebrew/include
CC		= gcc -g -fsanitize=address #arch -x86_64
#CFLAGS	= -Wall -Wextra -Werror

SRC_DIR		= ./srcs/
OBJ_DIR		= ./objs/
LIBFT_DIR	= ./libft/
INCDIR		= ./includes/

LIBFT = libft.a

SRC 	=	main.c error.c utils.c check.c init.c \
			command_filter.c exec_cmd.c using_free.c \
			make_command_list.c replace_env.c redirect_util.c \
			get_next_line_utils.c get_next_line.c sig_handler.c \
			set_connect_pipe.c redirect_filter.c redirection_dup.c\
			redirection_in_dup.c redirection_out_dup.c exec_builtin.c \
			merge_sort.c make_param.c utils_2.c copy_envp.c\
			write_env_file.c write_export_file.c\
			builtin_cd.c builtin_echo.c builtin_exit.c builtin_pwd.c\
			test_file.c

OBJ_FILES = $(SRC:.c=.o)
OBJS	= $(addprefix $(OBJ_DIR), $(OBJ_FILES))

# -L/opt/homebrew/Cellar/readline/8.1/lib -I/opt/homebrew/Cellar/readline/8.1/include
# -L/opt/homebrew/Cellar/readline/8.1/lib/ -I/opt/homebrew/include/
# /opt/homebrew/lib
LIBS	= ${LIBFT} -lreadline #-L/opt/homebrew/Cellar/readline/8.1/lib


all:		$(NAME)

$(NAME):	$(LIBFT) $(OBJS)
		$(CC) ${CFLAGS} -I$(INCDIR) -o ${NAME} $(OBJS) ${LIBS}

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR)
	@mv $(LIBFT_DIR)/${LIBFT} .

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) ${CFLAGS} -c $< -o $@

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	$(RM) $(OBJS)
	$(RM) -rf $(OBJ_DIR)

fclean:	clean
		$(RM) $(NAME)
		$(RM) ${LIBFT}

re: fclean all

.PHONY:	all bonus clean fclean re