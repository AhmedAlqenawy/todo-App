abstract class TaskStates{}

class ChangTabBarState extends TaskStates{}
class ChangDateState extends TaskStates{}

class GetTasksFromDatabaseState extends TaskStates{}

class GetTasksByDateFromDatabaseState extends TaskStates{}

class InsertTasksIntoDatabaseState extends TaskStates{}

class InitTaskState extends TaskStates{}

class GetFavoriteTaskListState extends TaskStates{}

class GetCompletedTaskListState extends TaskStates{}

class GetUncompletedTaskListState extends TaskStates{}

class UpdateTaskListState extends TaskStates{}

class DeleteTaskListState extends TaskStates{}